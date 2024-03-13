import gleam/regex
import gleam/list
import gleam/string
import gleam/option

pub type Option {
  Bytes
  Lines
}

pub fn parse(input: String) -> Result(List(Option), String) {
  let assert Ok(re) = regex.from_string("-([a-z]{1,})+")
  let input_options =
    regex.scan(with: re, content: input)
    |> list.flat_map(fn(match) { match.submatches })
    |> option.values
    |> string.join(with: "")

  case input_options {
    "c" -> Ok([Bytes])
    "cl" -> Ok([Bytes, Lines])
    _ -> Error("Invalid option " <> input <> ". \nUsage: wc [-clmw] [file ...]")
  }
}
