import gleeunit
import gleeunit/should
import internal/types.{Bytes, Chars, Command, Lines, Stdin, Words}
import internal/input_parser.{parse}

pub fn main() {
  gleeunit.main()
}

pub fn parse_c_bytes_test() {
  ["-c"]
  |> parse
  |> should.equal(Ok(Command(input: Stdin, options: [Bytes])))
}

pub fn parse_l_lines_test() {
  ["-l"]
  |> parse
  |> should.equal(Ok(Command(input: Stdin, options: [Lines])))
}

pub fn parse_w_words_test() {
  ["-w"]
  |> parse
  |> should.equal(Ok(Command(input: Stdin, options: [Words])))
}

pub fn parse_m_chars_test() {
  ["-m"]
  |> parse
  |> should.equal(Ok(Command(input: Stdin, options: [Chars])))
}

pub fn parse_input_stdin_test() {
  ["-c"]
  |> parse
  |> should.equal(Ok(Command(input: Stdin, options: [Bytes])))
}

pub fn parse_input_single_file_test() {
  1
  |> should.equal(1)
}

pub fn parse_multiple_options_test() {
  1
  |> should.equal(1)
}

pub fn parse_multiple_options_sorted_by_lwc_test() {
  1
  |> should.equal(1)
}

pub fn parse_no_args_default_to_lwc_test() {
  1
  |> should.equal(1)
}

pub fn parse_m_cancels_c_test() {
  1
  |> should.equal(1)
}

pub fn parse_c_cancels_m_test() {
  1
  |> should.equal(1)
}

pub fn parse_input_multiple_files_test() {
  1
  |> should.equal(1)
}
