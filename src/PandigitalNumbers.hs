
module PandigitalNumbers where

import Data.List

pandigital :: [(Int, Int, Int)]
pandigital = [(a, b, a+b) | a <- d3, b <- d3, a+b > 900, b > a, a+b > 999, unique [a, b, a+b]]
  where d3 = filter (unique . return) [100..999]
        unique = (\x -> x == nub x) . (show =<<)

--smallestPandigital :: Int
--smallestPandigital = first $ head pandigital

