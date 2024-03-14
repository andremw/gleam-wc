import gleam/list
import gleam/result
import internal/options_parser as op

pub type Input {
  Stdin
  Files(first: String, rest: List(String))
}

pub type Command {
  Command(input: Input, options: List(op.Option))
}

pub fn parse(raw_input: List(String)) -> Result(Command, String) {
  use raw_options <- result.try(
    list.at(raw_input, 0)
    |> result.map_error(fn(_) { "Input is empty!" }),
  )
  use options <- result.try(op.parse(raw_options))

  Ok(Command(input: Stdin, options: options))
}
