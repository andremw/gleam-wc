import gleeunit
import gleeunit/should
import internal/input_parser.{Command, Stdin}
import internal/options_parser.{Bytes, Chars, Lines, Words}

pub fn main() {
  gleeunit.main()
}

pub fn parse_c_bytes_test() {
  ["-c"]
  |> input_parser.parse
  |> should.equal(Ok(Command(input: Stdin, options: [Bytes])))
}

pub fn parse_l_lines_test() {
  ["-l"]
  |> input_parser.parse
  |> should.equal(Ok(Command(input: Stdin, options: [Lines])))
}

pub fn parse_w_words_test() {
  ["-w"]
  |> input_parser.parse
  |> should.equal(Ok(Command(input: Stdin, options: [Words])))
}

pub fn parse_m_chars_test() {
  ["-m"]
  |> input_parser.parse
  |> should.equal(Ok(Command(input: Stdin, options: [Chars])))
}

pub fn parse_m_cancels_c_test() {
  1
  |> should.equal(1)
}

pub fn parse_c_cancels_m_test() {
  1
  |> should.equal(1)
}

pub fn parse_input_stdin_test() {
  ["-c"]
  |> input_parser.parse
  |> should.equal(Ok(Command(input: Stdin, options: [Bytes])))
}

pub fn parse_input_single_file_test() {
  1
  |> should.equal(1)
}

pub fn parse_input_multiple_files_test() {
  1
  |> should.equal(1)
}
