
module BoyerMoore where


horspool :: Ord a => [a] -> Maybe Int -> [a] -> Maybe Int
horspool = undefined

test :: (String -> Maybe Int -> String -> Maybe Int) -> IO ()
test f = do assertEqual (f ""   Nothing  "Hello World") (Just 0)
            assertEqual (f "He" Nothing  "Hello World") (Just 0)
            assertEqual (f "od" Nothing  "Bonsai Code") (Just 8)
            assertEqual (f "ef" Nothing  "Bonsai Code") (Nothing)
            assertEqual (f ""   (Just 1) "Hello World") (Just 1)
            assertEqual (f "He" (Just 1) "Hello World") (Nothing)
            assertEqual (f "od" (Just 1) "Bonsai Code") (Just 8)
            assertEqual (f "ef" (Just 1) "Bonsai Code") (Nothing)
         where assertEqual a b = print (a == b, a, b)

main :: IO ()
main = test horspool

