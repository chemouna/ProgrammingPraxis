
module LexicographicPermutations where

import Data.List
import qualified Data.List.Key as K

lexic_perms :: (a -> a -> Bool) -> [a] -> [[a]]
lexic_perms cmp xs = map fst . K.sort (reverse . snd) . map unzip $
                         permutations [(x, length $ filter (cmp x) xs) | x <- xs]
