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
  // can't name Bytes or Lines because of conflict with Option
  OBytes(Int)
  OLines(Int)
}

pub type Output {
  Output(values: List(OutputValue))
}
