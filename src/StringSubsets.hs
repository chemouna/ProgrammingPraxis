module StringSubsets where

import Data.List
import qualified Data.Map as M
import qualified Data.IntMap as I
import Data.Maybe
import qualified Data.IntMultiSet as IM

-- get a count of all the characters in both strings and check if the second string has an equal
-- or higher count for all the characters in the first string (the second is the container string).
-- O(n * m)
subsetOf1 :: Ord a => [a] -> [a] -> Bool
subsetOf1 xs ys =  all (\(c, n) -> maybe False (n <=) . lookup c $ count ys) $ count xs
  where count = map (\x -> (head x, length x)) . group . sort

-- for faster lookup let's use Map. Like the previous version, counting the frequency of each letter is
-- O(n log n), but using Maps the comparison can now be done in O(m + n)
-- so overall O(n log n)
subsetOf2 :: Ord a => [a] -> [a] -> Bool
subsetOf2 xs ys = M.null $ M.differenceWith
  (\x y -> if x <= y then Nothing else Just x) (f xs) (f ys)
  where f = M.fromListWith (+) . map (flip (,) 1)


-- By converting the characters to integers we can use an IntMap instead of a plain Map.
-- An IntMap has a lookup of O(min(n,W)), with W being the amount of bits in an Int.
-- => in O(1) lookup
-- Counting all the letters can now be done in O(n). Since the comparison still takes O(m + n)
-- => O(m + n)
subsetOf3 :: Enum a => [a] -> [a] -> Bool
subsetOf3 xs ys = I.null $ I.differenceWith
    (\x y -> if x <= y then Nothing else Just x) (f xs) (f ys)
    where f = I.fromListWith (+) . map (flip (,) 1 . fromEnum)

-- using multi-set library: convert both strings to multi-sets of characters
-- and check if the second is a subset of the first.
subsetOf4 :: Enum a => [a] -> [a] -> Bool
subsetOf4 xs ys = IM.isSubsetOf (toSet xs) (toSet ys)
  where toSet = IM.fromList . map fromEnum

-- seems like there's something that can be generalized here ? 

main :: IO ()
main = do let test f = print (f "da" "abcd", not $ f "dad" "abcd")
          test subsetOf1
          test subsetOf2
          test subsetOf3
          test subsetOf4
