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

pub type OutputValue {
  OBytes(Int)
  // can't name Bytes because of conflict with Option
}

pub type Output {
  Output(values: List(OutputValue))
}
