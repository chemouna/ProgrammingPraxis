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

-- mondayFlipNumber = day [True, False, True]
-- tuesdayFlipNumber = day [True, False, False]
-- results show that monday's number is higher

-- | Improvement 2 to day with pointfree style
day_2 :: [Bool] -> IO Double
day_2 p = fmap (ap ((/) . fromIntegral . sum) (fromIntegral . length)) . replicateM 10000 $ flipUntil p

-- | ex 2
--  find the first year for which the sum of both groups of two digits is equal to the middle two digits.
sumDay :: Maybe Integer
sumDay = find (\d -> div d 100 + mod d 100 == div (mod d 1000) 10) [1979..]

-- result is 2307

main :: IO ()
main = do print =<< liftM2 compare (day [True, False, True])
                                   (day [True, False, False])
          print sumDay
