import argv
import gleam/io
import gleam/bit_array
import gleam/result
import gleam/list
import gleam/string
import gleam/regex
import simplifile.{read}
import gleam/int.{subtract}
import internal/input_parser
import internal/types as tp

@external(erlang, "wc_erl", "io_get_line")
fn io_get_stdin_line() -> tp.StdinResult(BitArray)

fn read_bytes(content: String) {
  content
  |> string.byte_size
}

fn read_lines(content: String) {
  let assert Ok(re) = regex.from_string("\\r\\n|\\r|\\n")
  content
  |> regex.split(with: re)
  |> list.length
  |> subtract(1)
}

fn read_words(content: String) {
  let assert Ok(re) = regex.from_string("\\s+")
  content
  |> string.trim
  |> regex.split(with: re)
  |> list.length
}

fn count_characters(content: String) {
  content
  |> string.to_utf_codepoints
  |> list.length
}

fn get_stdin_stats(
  zero_bytes bytes: Int,
  zero_lines lines: Int,
  zero_words words: Int,
  zero_chars chars: Int,
) -> Result(#(Int, Int, Int, Int), String) {
  case io_get_stdin_line() {
    tp.Eof -> Ok(#(bytes, lines, words, chars))
    tp.Error -> Error("Error reading stdin")
    tp.Ok(bits) -> {
      use content <- result.try(
        bits
        |> bit_array.to_string
        |> result.map_error(fn(_) { "Error converting bit_array to String" }),
      )

      io.print(content)

      let bytes = bytes + read_bytes(content)
      let lines = lines + 1
      let words = words + read_words(content)
      let chars = chars + count_characters(content)

      get_stdin_stats(bytes, lines, words, chars)
    }
  }
}

pub fn wc(raw_input: List(String)) -> Result(tp.Output, String) {
  use command <- result.try(
    raw_input
    |> input_parser.parse,
  )

  case command.input {
    tp.Stdin -> {
      use #(bytes, lines, words, chars) <- result.try(get_stdin_stats(
        zero_bytes: 0,
        zero_lines: 0,
        zero_words: 0,
        zero_chars: 0,
      ))

      command.options
      |> list.try_map(fn(option) {
        Ok(case option {
          tp.Bytes ->
            bytes
            |> tp.OBytes
          tp.Lines ->
            lines
            |> tp.OLines
          tp.Words ->
            words
            |> tp.OWords
          tp.Chars ->
            chars
            |> tp.OChars
        })
      })
      |> result.map(fn(values) { tp.Output(values: values) })
    }
    tp.Files(first, rest) -> {
      [first, ..rest]
      |> list.try_map(fn(file) {
        use content <- result.try(
          file
          |> read
          |> result.map_error(fn(_e) { "Error reading file" }),
        )

        command.options
        |> list.try_map(fn(option) {
          Ok(case option {
            tp.Bytes ->
              content
              |> read_bytes
              |> tp.OBytes
            tp.Lines ->
              content
              |> read_lines
              |> tp.OLines
            tp.Words ->
              content
              |> read_words
              |> tp.OWords
            tp.Chars ->
              content
              |> count_characters
              |> tp.OChars
          })
        })
      })
      |> result.map(list.flatten)
      |> result.map(fn(values) { tp.Output(values: values) })
    }
  }
}

pub fn main() {
  argv.load().arguments
  |> wc
  |> io.debug
}
