import gleam/list
import gleam/result
import gleam/string
import internal/options_parser as op
import internal/types as tp

fn or_default_options_string(options) {
  case options {
    "" -> "-lwc"
    otherwise -> otherwise
  }
}

pub fn parse(raw_input: List(String)) -> Result(tp.Command, String) {
  let #(raw_options, files) =
    raw_input
    |> list.partition(fn(x) { string.starts_with(x, "-") })
  let joined_options =
    raw_options
    |> string.join("")
    |> or_default_options_string
  use options <- result.try(op.parse(joined_options))

  let input = case files {
    [] -> tp.Stdin
    [file] -> tp.Files(first: file, rest: [])
    [file, ..rest] -> tp.Files(first: file, rest: rest)
  }

  Ok(tp.Command(input: input, options: options))
}
