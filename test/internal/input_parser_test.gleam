import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

pub fn parse_input_single_file_test() {
  1
  |> should.equal(1)
}

pub fn parse_input_multiple_files_test() {
  1
  |> should.equal(1)
}

pub fn parse_input_stdin_test() {
  1
  |> should.equal(1)
}

pub fn parse_c_bytes_test() {
  1
  |> should.equal(1)
}

pub fn parse_l_lines_test() {
  1
  |> should.equal(1)
}

pub fn parse_w_words_test() {
  1
  |> should.equal(1)
}

pub fn parse_m_chars_test() {
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
