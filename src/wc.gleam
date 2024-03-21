import file_streams/read_text_stream
import gleam/list
import gleam/regex
import gleam/result
import gleam/string
import internal/input_parser
import internal/types as tp

fn read_bytes(content: String) {
  content
  |> string.byte_size
}

fn read_words(content: String) {
  let assert Ok(re) = regex.from_string("\\s+")
  content
  |> string.trim
  |> regex.split(with: re)
  |> list.length
}

fn count_characters(content: String) {
  content
  |> string.to_utf_codepoints
  |> list.length
}

fn get_file_stats(
  from read_stream,
  zero_bytes bytes: Int,
  zero_lines lines: Int,
  zero_words words: Int,
  zero_chars chars: Int,
) -> Result(#(Int, Int, Int, Int), String) {
  case read_text_stream.read_line(read_stream) {
    Error(_) -> Ok(#(bytes, lines, words, chars))
    Ok(content) -> {
      let bytes = bytes + read_bytes(content)
      let lines = lines + 1
      let words = words + read_words(content)
      let chars = chars + count_characters(content)

      get_file_stats(read_stream, bytes, lines, words, chars)
    }
  }
}

pub fn wc(raw_input: List(String)) -> Result(tp.Output, String) {
  use command <- result.try(
    raw_input
    |> input_parser.parse,
  )

  case command.input {
    tp.Stdin -> Ok(tp.Output(values: [tp.OBytes(1)]))
    tp.Files(first, rest) -> {
      [first, ..rest]
      |> list.try_map(fn(file) {
        use stream <- result.try(
          file
          |> read_text_stream.open
          |> result.map_error(fn(_) { "Failed to open stream " }),
        )

        use #(bytes, lines, words, chars) <- result.try(get_file_stats(
          from: stream,
          zero_bytes: 0,
          zero_lines: 0,
          zero_words: 0,
          zero_chars: 0,
        ))

        read_text_stream.close(stream)

        command.options
        |> list.try_map(fn(opt) {
          case opt {
            tp.Bytes -> Ok(tp.OBytes(bytes))
            tp.Lines -> Ok(tp.OLines(lines))
            tp.Words -> Ok(tp.OWords(words))
            tp.Chars -> Ok(tp.OChars(chars))
          }
        })
      })
      |> result.map(list.flatten)
      |> result.map(fn(values) { tp.Output(values: values) })
    }
  }
}
