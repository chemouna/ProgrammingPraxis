{-# LANGUAGE TemplateHaskell #-}
module TwoSubQuadraticSorts where

import Data.List
import Control.Arrow
import Control.Monad
import Test.QuickCheck
import Test.QuickCheck.All

import Data.List
import Control.Arrow
import Control.Monad

flgInsert x xs = ((x:xs==) &&& id) $ insert x xs

gapSwapping k = (and *** concat . transpose) . unzip
  . map (foldr (\x (b,xs) -> first (b &&) $ flgInsert x xs) (True,[]))
  . transpose . takeWhile (not . null) . unfoldr (Just . splitAt k)

combSort xs = (snd. fst) $ until (\((b,_), gap) -> b && gap == 1)
    (\((_,xs), gap) -> (gapSwapping gap xs, fg gap)) ((False, xs), fg $ length xs)
  where fg = max 1 . truncate . (/1.25) . fromIntegral

prop_idempotent xs = combSort (combSort xs) == combSort xs
prop_minimum xs    = not (null xs) ==> head (combSort xs) == minimum xs

prop_ordered xs = ordered (combSort xs)
    where ordered []       = True
          ordered [x]      = True
          ordered (x:y:xs) = x <= y && ordered (y:xs)

prop_permutation xs = permutation xs (combSort xs)
    where permutation xs ys = null (xs \\ ys) && null (ys \\ xs)

prop_maximum xs =
    not (null xs) ==>
        last (combSort xs) == maximum xs

prop_append xs ys =
    not (null xs) ==>
    not (null ys) ==>
        head (combSort (xs ++ ys)) == min (minimum xs) (minimum ys)

return []
main = $(quickCheckAll)

-- TODO: debug this as its failing on some inputs
