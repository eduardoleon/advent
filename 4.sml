val low = 183564
val high = 657474

fun test (b, 0, ss) = if b then SOME ss else NONE
  | test (b, n, nil) = test (b, n div 10, n mod 10 :: nil)
  | test (b, n, s :: ss) =
    let
      val q = n div 10
      val r = n mod 10
    in
      case Int.compare (r, s) of
          LESS => test (b, q, r :: s :: ss)
        | EQUAL => test (true, q, r :: s :: ss)
        | GREATER => NONE
    end

fun inner (c, x, nil) = (c, nil)
  | inner (c, x, y :: ys) =
    if x = y then
      inner (c + 1, x, ys)
    else
      (c, y :: ys)

fun outer nil = false
  | outer (x :: xs) =
    case inner (1, x, xs) of
        (2, _) => true
      | (_, xs) => outer xs

fun id x = x

fun program (low, high) =
  let
    fun digits n = test (false, n + low, nil)
    val xs = List.tabulate (high - low + 1, digits)
    val ys = List.mapPartial id xs
    val zs = List.filter outer ys
  in
    { a = length ys, b = length zs }
  end
