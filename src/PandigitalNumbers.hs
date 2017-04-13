
module PandigitalNumbers where

import Data.List
-- import Control.Lens

pandigital :: [(Int, Int, Int)]
pandigital = [(a, b, a+b) | a <- d3, b <- d3, a+b > 900, b > a, a+b > 999, unique [a, b, a+b]]
  where d3 = filter (unique . return) [100..999]
        unique = (\x -> x == nub x) . (show =<<)

smallestPandigital :: Int
smallestPandigital = (head pandigital) ^. _1

main :: IO ()
main = do print $ head pandigital == (246,789,1035) && smallestPandigital == 246
          print pandigital

          
