module CommaQuibbling where

quibbles :: [String] -> String
quibbles l = "{" ++ (commaq l) ++ "}"
commaq [] = ""
commaq [x] = x
commaq [x, y] =  x ++ " and " ++ y
commaq (x:xs) = x ++ ", " ++ (commaq xs)

