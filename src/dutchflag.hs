module DutchFlag where

import qualified Data.Vector as V

swap :: Int -> Int -> V.Vector a -> V.Vector a
swap i j a = a V.// [(i, a V.! j), (j, a V.! i)]

dutchFlag :: V.Vector Char -> V.Vector Char
dutchFlag xs = f (0, V.length xs - 1) xs 0 where
    f (r, b) a n = if n > b then a else case a V.! n of
      'R' -> f (r+1, b) (swap n r a) (n+1)
      'B' -> f (r, b-1) (swap n b a) n
      _  -> f (r, b) a (n+1)


test :: String -> Bool
test x = dutchFlag (V.fromList x) == V.fromList
  (filter (== 'R') x ++ filter (== 'W') x ++ filter (== 'B') x)

main :: IO ()
main = do print $ test ""
          print $ test "W"
          print $ test "R"
          print $ test "B"
          print $ test "RWB"
          print $ test "BWR"
          print $ test "RWBR"
          print $ test "WRBRBRBWRWBWBRBWRBWRBWRBWBBBRBRWBRWB"
