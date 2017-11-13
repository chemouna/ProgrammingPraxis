module MajorityElement where


import Data.List (foldr)
import Prelude hiding (foldr)

-- | /O(length xs)/, Determines if there in a list of votes /xs/ is a candidate
-- that has more than half of the votes, and if so, returns that canditate.
--
-- E.g. applying @majority@ on the string @\"AAACCBBCCCBCC\"@ yields
-- @Just \'C\'@, since @\'C\'@ has 7 out of 13 votes.

majority :: Eq a => [a] -> Maybe a
majority xs = eliminate xs >>= verify xs

-- First pass: eliminates all but a single candidate.
eliminate :: Eq a => [a] -> Maybe a
eliminate []     = Nothing
eliminate (x:xs) = Just (eliminate1 x xs)

eliminate1 :: Eq a => a -> [a] -> a
eliminate1 can0 = fst . foldr step (can0, 1 :: Int)

  where

    {-# INLINE step #-}
    step x (can, cnt)
      | can == x  = (can, succ cnt)
      | cnt == 0  = (x  , 1       )
      | otherwise = (can, pred cnt)

-- Second pass: asserts that the remaining candidate is a majority.
verify :: Eq a => [a] -> a -> Maybe a
verify xs can | verify1 can xs = Just can
              | otherwise      = Nothing

verify1 :: Eq a => a -> [a] -> Bool
verify1 can = (> 0) . foldr step (0 :: Int)

  where

    {-# INLINE step #-}
    step x cnt
      | can == x  = succ cnt
      | otherwise = pred cnt

