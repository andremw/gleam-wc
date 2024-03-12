import gleam/io

pub type Files {
  Files(
    first: String,
    rest: List(String)
  )
}

pub type Command {
  Command(
    files: Files,
  )
}

pub fn main() {
  io.println("Hello from wc!")
}
