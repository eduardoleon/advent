fun program name =
  let
    val strm = TextIO.openIn name
    val text = TextIO.inputAll strm before TextIO.closeIn strm
    val code = String.tokens Char.isPunct text
    val code = List.mapPartial Int.fromString code
    val code = Vector.fromList code
    val buffer = Array.array (Vector.length code, 0)
    val params = { src = code, dst = buffer, di = 0 }
    
    fun sub pos = Array.sub (buffer, pos)
    fun update (pos, value) = Array.update (buffer, pos, value)
    
    fun step op@ pos =
      let
        val arg1 = sub (pos + 1)
        val arg2 = sub (pos + 2)
        val arg3 = sub (pos + 3)
      in
        update (arg3, sub arg1 @ sub arg2)
      end
    
    fun loop pos =
      case sub pos of
          1 => (step op+ pos; loop (pos + 4))
        | 2 => (step op* pos; loop (pos + 4))
        | _ => sub 0
    
    fun run (a, b) = (Array.copyVec params; update (1, a); update (2, b); loop 0)
    
    fun coord n = (n div 100, n mod 100)
    fun test args = run args = 19690720
    val args = List.tabulate (10000, coord)
  in
    { a = run (12, 2), b = List.filter test args }
  end
