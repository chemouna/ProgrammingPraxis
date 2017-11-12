module ListIntersectionUnion where

import qualified Data.IntSet as I
import qualified Data.Set as S
import System.CPUTime
import Text.Printf

genUnion, genIntersect :: ([a] -> b) -> (a -> b -> Bool) -> [a] -> [a] -> [a]
genUnion load get xs ys = xs ++ filter (not . flip get (load xs)) ys
genIntersect load get xs ys = filter (`get` (load ys)) xs

-- for O(n^2) we use a linked list data structure
-- so no conversion is needed
union_o_n2, intersect_o_n2 :: Eq a => [a] -> [a] -> [a]
union_o_n2 = genUnion id elem
intersect_o_n2 = genIntersect id elem

-- Using a Set we get a lookup of O(log n) so we get complexity of O(n log n)
union_o_nlogn, intersect_o_nlogn :: Ord a => [a] -> [a] -> [a]
union_o_nlogn = genUnion S.fromList S.member
intersect_o_nlogn = genIntersect S.fromList S.member


-- Using IntSet we get O(1) lookup and overall complexity of O(n)
union_o_n, intersect_o_n :: [Int] -> [Int] -> [Int]
union_o_n = genUnion I.fromList I.member
intersect_o_n = genIntersect I.fromList I.member


time :: a -> IO Integer
time f = do start <- getCPUTime
            _     <- return $! f
            end   <- getCPUTime
            return (div (end - start) (10^9))

benchmark :: ([Int] -> [Int] -> [Int]) -> [Int] -> IO ()
benchmark f ns = putStrLn . (printf "%7d" =<<) =<<
                 mapM (\n -> time (length $ f [1..n] [1..n])) ns


main :: IO ()
main = do let a = [4,7,12,6,17,5,13]
          let b = [7,19,4,11,13,2,15]
          let testUnion f = print $ f a b == [4,7,12,6,17,5,13,19,11,2,15]
          let testIsect f = print $ f a b == [4,7,13]
          testUnion union_o_n2
          testIsect intersect_o_n2
          testUnion union_o_nlogn
          testIsect intersect_o_nlogn
          testUnion union_o_n
          testIsect intersect_o_n

          let ns = iterate (*2) 10000
          benchmark union_o_n2    $ take 4 ns
          benchmark union_o_nlogn $ take 8 ns
          benchmark union_o_n     $ take 8 ns
