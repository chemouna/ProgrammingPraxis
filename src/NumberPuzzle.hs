module NumberPuzzle where

import Debug.Trace

gen :: Int -> [Int]
gen n
    | n == 5 = [5]
    | n == 10 = [0]
    | n `mod` 2 == 0 = [2,4,6,8]
    | otherwise = [1,3,7,9]

solverec :: Int -> Int -> Int -> [Int] -> [Int]
solverec b n q s
    | n == 11 = [q]
    | otherwise =
        trace "-----------------------------------"
        trace (" q: " ++ show q) $
        trace (" n:  " ++ show n)
        concatMap
        (\x ->
            let j = b * q + x in
               trace ("  j: " ++ show j) $
               if j `mod` n /= 0 || x `elem` s
               then trace " we found case where not divisible by n so ignoring it and going to next value of gen"
                 []
               else
                 trace "we found case where div by n so lets do it for the rest"
                 solverec b (n + 1) j (x:s))
        (gen n)

solve :: Int -> [Int]
solve b = solverec b 1 0 []

main :: IO ()
main = print(head(solve 10))
