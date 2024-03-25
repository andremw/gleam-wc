import gleam/result
import gleam/list
import gleam/string
import gleam/regex
import gleam/int.{subtract}
import internal/input_parser
import internal/types as tp
import simplifile.{read}

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

pub fn wc(raw_input: List(String)) -> Result(tp.Output, String) {
  use command <- result.try(
    raw_input
    |> input_parser.parse,
  )

  case command.input {
    tp.Stdin -> Ok(tp.Output(values: [tp.OBytes(1)]))
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
