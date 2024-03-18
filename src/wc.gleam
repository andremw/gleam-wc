import gleam/result
import gleam/list
import gleam/bit_array
import gleam/string
import gleam/regex
import internal/input_parser
import internal/types as tp
import simplifile.{read, read_bits}

fn read_bytes(file: String) {
  file
  |> read_bits
  |> result.map(bit_array.byte_size)
}

fn read_lines(file: String) {
  file
  |> read
  |> result.map(fn(content) {
    content
    |> string.split("\n")
    |> list.length
  })
}

fn read_words(file: String) {
  file
  |> read
  |> result.map(fn(content) {
    let assert Ok(re) = regex.from_string("\\s+")
    content
    |> string.trim
    |> regex.split(with: re)
    |> list.length
  })
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
        command.options
        |> list.try_map(fn(option) {
          case option {
            tp.Bytes ->
              file
              |> read_bytes
              |> result.map(tp.OBytes)
              |> result.map_error(fn(_e) { "Error reading file" })
            tp.Lines ->
              file
              |> read_lines
              |> result.map(tp.OLines)
              |> result.map_error(fn(_e) { "Error reading file" })
            tp.Words ->
              file
              |> read_words
              |> result.map(tp.OWords)
              |> result.map_error(fn(_e) { "Error reading file" })
            _ -> Ok(tp.OBytes(1))
          }
        })
      })
      |> result.map(list.flatten)
      |> result.map(fn(values) { tp.Output(values: values) })
    }
  }
}
