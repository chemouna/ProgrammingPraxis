module NumberPuzzle where


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
        -- trace (" -- " ++ show k) $
        concatMap
        (\d ->
            let j = 10*k+d in
               if j `mod` n /= 0 || d `elem` s
               then []
               else solve (n+1) j (d:s))
        (gen n)

main :: IO ()
main = print(head(solve 1 0 []))
