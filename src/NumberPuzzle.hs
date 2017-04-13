module NumberPuzzle where

import Debug.Trace

gen :: Int -> [Int]
gen n
    | n == 5 = [5]
    | n == 10 = [0]
    | n `mod` 2 == 0 = [2,4,6,8]
    | otherwise = [1,3,7,9]

solve :: Int -> Int -> [Int] -> [Int]
solve n k s
    | n == 11 = [k]
    | otherwise =
        trace (" -- k: " ++ show k) $
        trace (" --- n:  " ++ show n)
        concatMap
        (\x ->
            let j = 10 * k + x in 
               trace (" ---- j: " ++ show j) $
               if j `mod` n /= 0 || x `elem` s
               then []
               else solve (n + 1) j (x:s))
        (gen n)

main :: IO ()
main = print(head(solve 1 0 []))
