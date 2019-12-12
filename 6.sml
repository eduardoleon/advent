datatype planet = Planet of bool ref * (int * int) ref * planet option ref * planet list ref

fun planet () = Planet (ref false, ref (0, 0), ref NONE, ref nil)
fun orbits (Planet (_, n, _, _)) = !n
fun parent (Planet (_, _, p, _)) = !p
fun children (Planet (_, _, _, ps)) = !ps

fun connect (parent, child) =
  let
    val Planet (_, _, _, ps) = parent
    val Planet (_, _, p, _) = child
  in
    p := SOME parent;
    ps := child :: !ps
  end

fun loop (m, n, nil) = (m, n)
  | loop (m, n, p :: ps) =
    let val (dm, dn) = orbits p
    in loop (m + dm + 1, n + dm + dn + 1, ps) end

fun visit (Planet (b, n, _, ps)) =
  if !b then
    (n := loop (0, 0, !ps); true)
  else
    (b := true; false)

fun loop nil = ()
  | loop (nil :: ps) = loop ps
  | loop ((p :: ps) :: pss) =
    if visit p then
      loop (ps :: pss)
    else
      loop (children p :: (p :: ps) :: pss)

fun visit p = loop [[p]]

fun loop (ps, NONE) = ps
  | loop (ps, SOME p) =
    let val p = parent p
    in loop (p :: ps, p) end

fun path p = loop (nil, SOME p)

fun loop (p :: ps, q :: qs) = if p = q then loop (ps, qs) else (p :: ps, q :: qs)
  | loop args = args

fun discard (p, q) =
  let val (ps, qs) = loop (path p, path q)
  in length ps + length qs end

fun program name =
  let
    val strm = TextIO.openIn name
    val text = TextIO.inputAll strm before TextIO.closeIn strm
    val lines = String.tokens Char.isSpace text
    val table = HashArray.hash (length lines * 2)
    
    fun ensure name =
      case HashArray.sub (table, name) of
          SOME p => p
        | NONE =>
          let val p = planet ()
          in HashArray.update (table, name, p); p end
    
    fun prepare line =
      case String.tokens Char.isPunct line of
          [parent, child] => connect (ensure parent, ensure child)
        | _ => ()
    
    val center = ensure "COM"
    val santa = ensure "SAN"
    val you = ensure "YOU"
  in
    app prepare lines;
    visit center;
    { a = #2 (orbits center), b = discard (santa, you) }
  end
