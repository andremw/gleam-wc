pub type Option {
  Bytes
}

pub fn parse(input: String) -> Result(Option, String) {
  case input {
    "-c" -> Ok(Bytes)
    _ -> Error("Invalid option " <> input <> ". \nUsage: wc [-clmw] [file ...]")
  }
}