import gleeunit
import gleeunit/should
import wc.{wc}
import internal/types.{OBytes, OChars, OLines, OWords, Output}

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
  ["-w", "test.txt"]
  |> wc
  |> should.equal(Ok(Output(values: [OWords(58_164)])))
}

pub fn get_number_of_characters_in_a_file_test() {
  ["-m", "test.txt"]
  |> wc
  |> should.equal(Ok(Output(values: [OChars(339_292)])))
}

pub fn get_default_output_test() {
  ["test.txt"]
  |> wc
  |> should.equal(
    Ok(Output(values: [OLines(7146), OWords(58_164), OBytes(342_190)])),
  )
}
