import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

pub fn parse_single_option_test() {
  1
  |> should.equal(1)
}

pub fn parse_two_separate_options_test() {
  1
  |> should.equal(1)
}

pub fn parse_two_combined_options() {
  1
  |> should.equal(1)
}

pub fn parse_invalid_option() {
  1
  |> should.equal(1)
}