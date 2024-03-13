pub type Input {
  Stdin
  Files(
    first: String,
    rest: List(String)
  )
}

pub type Command {
  Command(
    input: Input,
  )
}

pub fn parse(raw_input: List(string)) -> Result(Command, String) {
  case raw_input {
    [_] -> Ok(Command(input: Stdin))
    _ -> Error("No input provided")
  }
}