import gleam/regex
import gleam/list
import gleam/option
import gleam/result
import gleam/string
import internal/types as tp

pub fn parse(input: String) -> Result(List(tp.Option), String) {
  let assert Ok(re) = regex.from_string("-([a-z]{1,})+")
  regex.scan(with: re, content: input)
  |> list.flat_map(fn(match) { match.submatches })
  |> option.values
  |> list.flat_map(string.split(_, ""))
  |> list.map(fn(option) {
    case option {
      "c" -> Ok(tp.Bytes)
      "l" -> Ok(tp.Lines)
      "w" -> Ok(tp.Words)
      "m" -> Ok(tp.Chars)
      _ ->
        Error(
          "Invalid option -- " <> option <> ". \nUsage: wc [-clmw] [file ...]",
        )
    }
  })
  |> list.unique
  |> result.all
}
