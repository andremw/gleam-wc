import gleam/io

pub type Input {
  Stdin
  Files(
    first: String,
    rest: List(String)
  )
}

pub type Command {
  Command(
    input: Input
  )
}

pub fn main() {
  io.println("Hello from wc!")
}
