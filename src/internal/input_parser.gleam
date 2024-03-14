import gleam/list
import gleam/result
import gleam/string
import gleam/order
import internal/options_parser as op
import internal/types as tp

fn or_default_options_string(options) {
  case options {
    "" -> "-lwc"
    otherwise -> otherwise
  }
}

fn option_to_number(option) {
  case option {
    tp.Lines -> 0
    tp.Words -> 1
    tp.Bytes -> 2
    tp.Chars -> 2
  }
}

fn sort_options(opt1, opt2) -> order.Order {
  case option_to_number(opt1), option_to_number(opt2) {
    num1, num2 if num1 < num2 -> order.Lt
    num1, num2 if num1 > num2 -> order.Gt
    _, _ -> order.Eq
  }
}

fn handle_mutually_exclusive_option(options, option) -> List(tp.Option) {
  case option {
    tp.Bytes ->
      case
        options
        |> list.contains(any: tp.Chars)
      {
        True -> options
        False -> list.append(options, [option])
      }
    tp.Chars ->
      case
        options
        |> list.contains(any: tp.Bytes)
      {
        True -> options
        False -> list.append(options, [option])
      }
    _ -> list.append(options, [option])
  }
}

pub fn parse(raw_input: List(String)) -> Result(tp.Command, String) {
  let #(raw_options, files) =
    raw_input
    |> list.partition(string.starts_with(_, "-"))

  let joined_options =
    raw_options
    |> string.join("")
    |> or_default_options_string

  use options <- result.try(
    op.parse(joined_options)
    |> result.map(list.fold(_, from: [], with: handle_mutually_exclusive_option))
    |> result.map(list.sort(_, by: sort_options)),
  )

  let input = case files {
    [] -> tp.Stdin
    [file] -> tp.Files(first: file, rest: [])
    [file, ..rest] -> tp.Files(first: file, rest: rest)
  }

  Ok(tp.Command(input: input, options: options))
}
