import gleeunit
import gleeunit/should
import wc.{wc}
import internal/types.{OBytes, OLines, Output}

pub fn main() {
  gleeunit.main()
}

pub fn get_number_of_bytes_in_a_file_test() {
  ["-c", "test.txt"]
  |> wc
  |> should.equal(Ok(Output(values: [OBytes(342_190)])))
}

pub fn get_number_of_lines_in_a_file_test() {
  ["-l", "test.txt"]
  |> wc
  |> should.equal(Ok(Output(values: [OLines(7146)])))
}

pub fn get_number_of_words_in_a_file_test() {
  1
  |> should.equal(1)
}

pub fn get_number_of_characters_in_a_file_test() {
  1
  |> should.equal(1)
}

pub fn get_default_output_test() {
  1
  |> should.equal(1)
}

pub fn get_default_output_from_stdin_test() {
  1
  |> should.equal(1)
}
