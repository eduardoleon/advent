fun fuel mass = if mass < 9 then NONE else SOME (mass div 3 - 2)
fun loop (sum, nil) = sum
  | loop (sum, masses) = loop (foldl op+ sum masses, List.mapPartial fuel masses)

fun program name =
  let
    val strm = TextIO.openIn name
    val text = TextIO.inputAll strm before TextIO.closeIn strm
    val masses = String.tokens Char.isSpace text
    val masses = List.mapPartial Int.fromString masses
    val masses = List.mapPartial fuel masses
  in
    { a = foldl op+ 0 masses, b = loop (0, masses) }
  end
