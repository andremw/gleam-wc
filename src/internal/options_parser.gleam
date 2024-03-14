import gleam/regex
import gleam/list
import gleam/option
import gleam/result

pub type Option {
  Bytes
  Lines
  Words
  Chars
}

pub fn parse(input: String) -> Result(List(Option), String) {
  let assert Ok(re) = regex.from_string("-([a-z]{1,})+")
  regex.scan(with: re, content: input)
  |> list.flat_map(fn(match) { match.submatches })
  |> option.values
  |> list.map(fn(option) {
    case option {
      "c" -> Ok(Bytes)
      "l" -> Ok(Lines)
      "w" -> Ok(Words)
      "m" -> Ok(Chars)
      _ ->
        Error("Invalid option " <> option <> ". \nUsage: wc [-clmw] [file ...]")
    }
  })
  |> result.all
}
