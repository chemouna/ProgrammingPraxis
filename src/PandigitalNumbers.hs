module PandigitalNumbers where

import Data.List
import Control.Lens

pandigital :: [(Int, Int, Int)]
pandigital = [(a, b, a+b) | a <- v, b <- v, b > a, a+b > 999, unique [a, b, a+b]]
  where v = filter (unique . return) [100..999]
        unique = (\x -> x == nub x) . (show =<<)

smallestPandigital :: Int
smallestPandigital = head pandigital ^. _1

main :: IO ()
main = do print $ head pandigital == (246,789,1035) && smallestPandigital == 246
          print pandigital
