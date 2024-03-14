import gleeunit
import gleeunit/should
import internal/types.{Bytes, Lines}
import internal/options_parser.{parse}

pub fn main() {
  gleeunit.main()
}

pub fn parse_single_option_test() {
  "-c"
  |> parse
  |> should.equal(Ok([Bytes]))
}

pub fn parse_two_separate_options_test() {
  "-c -l"
  |> parse
  |> should.equal(Ok([Bytes, Lines]))
}

pub fn parse_invalid_option_test() {
  "-x"
  |> parse
  |> should.equal(Error("Invalid option -- x. \nUsage: wc [-clmw] [file ...]"))
}

pub fn parse_invalid_option_with_valid_option_test() {
  "-c -x -l"
  |> parse
  |> should.equal(Error("Invalid option -- x. \nUsage: wc [-clmw] [file ...]"))
}

pub fn parse_duplicated_options_test() {
  "-c -c -l"
  |> parse
  |> should.equal(Ok([Bytes, Lines]))
}
