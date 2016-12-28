module MindCipher where

import Control.Monad
import Data.List
import System.Random

-- | consider Head : True and Tail : False

-- | to simulate a series of flips.
flipUntil :: [Bool] -> IO Int
flipUntil p = fmap (length . takeWhile (not . isPrefixOf p) . tails . randomRs (False, True)) newStdGen

-- | to simulate an entire day we repeat the series of flips 10000 times and we calculate the average.
day :: [Bool] -> IO Double
day p = fmap (\a -> fromIntegral (sum a) / fromIntegral (length a)) . replicateM 10000 $ flipUntil p

mondayFlipNumber = day [True, False, True]

tuesdayFlipNumber = day [True, False, False]

-- results show that monday's number is higher

-- | Improvement 2 to day with pointfree style
day_2 p = fmap (ap ((/) . fromIntegral . sum) (fromIntegral . length)) . replicateM 10000 $ flipUntil p

