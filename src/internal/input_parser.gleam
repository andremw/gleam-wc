import gleam/list
import gleam/result
import internal/options_parser as op
import internal/types as tp

pub fn parse(raw_input: List(String)) -> Result(tp.Command, String) {
  use raw_options <- result.try(
    list.at(raw_input, 0)
    |> result.map_error(fn(_) { "Input is empty!" })
    |> result.or(Ok("-lwc")),
  )
  use options <- result.try(op.parse(raw_options))

  Ok(tp.Command(input: tp.Stdin, options: options))
}
