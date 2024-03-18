import gleam/result
import gleam/list
import gleam/bit_array
import internal/input_parser
import internal/types as tp
import simplifile.{read_bits}

fn read_bytes(file: String) {
  file
  |> read_bits
  |> result.map(bit_array.byte_size)
  |> result.map(tp.OBytes)
  |> result.map_error(fn(_e) { "Error reading file" })
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
        file
        |> read_bytes
      })
      |> result.map(fn(values) { tp.Output(values: values) })
    }
  }
}
