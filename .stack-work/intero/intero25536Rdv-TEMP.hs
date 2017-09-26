module CommaQuibbling where

commaq :: [String] -> String
commaq [] = ""
commaq [x] = x
commaq (x:[y]) =  x ++ " and " ++ y
commaq (x:xs) = x ++ ", " ++ (commaq xs)
