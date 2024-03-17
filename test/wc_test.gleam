import gleeunit
import gleeunit/should
import wc.{wc}
import internal/types.{OBytes, Output}

pub fn main() {
  gleeunit.main()
}

pub fn get_number_of_bytes_in_a_file_test() {
  ["-c", "test.txt"]
  |> wc
  |> should.equal(Ok(Output(values: [OBytes(342_190)])))
}
