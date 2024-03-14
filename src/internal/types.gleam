pub type Input {
  Stdin
  Files(first: String, rest: List(String))
}

pub type Option {
  Bytes
  Lines
  Words
  Chars
}

pub type Command {
  Command(input: Input, options: List(Option))
}
