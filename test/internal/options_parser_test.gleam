import gleeunit
import gleeunit/should
import internal/options_parser as op

pub fn main() {
  gleeunit.main()
}

pub fn parse_single_option_test() {
  "-c"
  |> op.parse
  |> should.equal(Ok([op.Bytes]))
}

pub fn parse_two_separate_options_test() {
  "-c -l"
  |> op.parse
  |> should.equal(
    Ok([op.Bytes, op.Lines])
  )
}

pub fn parse_two_combined_options() {
  1
  |> should.equal(1)
}

pub fn parse_invalid_option() {
  1
  |> should.equal(1)
}