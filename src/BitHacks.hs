
module BitHacks where

import Data.Bits
import Data.Maybe

-- Determine the sign of an integer.
-- Determine if two integers have the same sign.
-- Determine the absolute value of an integer without branching.

negative :: Int -> Bool
negative x = testBit x (bitSize x - 1)

negative' :: Int -> Bool
negative' x = testBitDefault x ((fromJust . bitSizeMaybe $ x) - 1)
