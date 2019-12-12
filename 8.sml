val width = 25
val height = 6
val size = height * width

structure A = CharArraySlice
structure S = Substring

fun inner (i, j, k, layer) =
  case S.getc layer of
      SOME (#"0", layer) => inner (i + 1, j, k, layer)
    | SOME (#"1", layer) => inner (i, j + 1, k, layer)
    | SOME (#"2", layer) => inner (i, j, k + 1, layer)
    | _ => (i, j, k)

fun outer (text, old) =
  if S.size text < size then
    #2 old * #3 old
  else
    let val (layer, text) = S.splitAt (text, size)
        val new = inner (0, 0, 0, layer)
        val old = if #1 old < #1 new then old else new
    in outer (text, old) end

fun pick text =
  let val state = (size, 0, 0)
  in outer (text, state) end

fun inner (slice, layer) =
  case (A.getItem slice, S.getc layer) of
      (SOME (#"2", slice'), SOME (#"0", layer)) => (A.update (slice, 0, #" "); inner (slice', layer))
    | (SOME (#"2", slice'), SOME (#"1", layer)) => (A.update (slice, 0, #"*"); inner (slice', layer))
    | (SOME (_, slice), SOME (_, layer)) => inner (slice, layer)
    | _ => ()

fun outer (slice, text) =
  if S.size text < size then
    ()
  else
    let val (layer, text) = S.splitAt (text, size)
    in inner (slice, layer); outer (slice, text) end

fun apply (array, text) = outer (A.full array, text)

fun loop (n, array) =
  if n = size then
    ()
  else
    let
      val slice = A.slice (array, n, SOME width)
    in
      print (A.vector slice);
      print "\n";
      loop (n + width, array)
    end

fun display array = loop (0, array)

fun program name =
  let
    val strm = TextIO.openIn name
    val text = TextIO.inputAll strm before TextIO.closeIn strm
    val text = S.full text
    val array = CharArray.array (size, #"2")
  in
    apply (array, text);
    display array;
    pick text
  end
