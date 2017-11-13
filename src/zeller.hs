
module Zeller where

import Data.Time.Calendar
import Data.Time.Calendar.WeekDate

data Weekday = Su | Mo | Tu | We | Th | Fr | Sa deriving (Enum, Eq, Show)

zeller :: Int -> Int -> Int -> Weekday
zeller year month day = toEnum $ mod (day + div (13 * m - 1) 5 + d + div d 4 + div c 4 - 2 * c) 7
  where
    y = if month < 3 then year - 1 else year
    m = if month < 3 then month + 10 else month - 2
    (c, d) = divMod y 100

test :: Day -> Bool
test date = zeller (fromEnum y) m d == toEnum (mod w 7) where
    (y, m, d) = toGregorian date
    (_, _, w) = toWeekDate date

main :: IO ()
main = do print $ zeller 2010 10 8 == Fr
          print $ all test [fromGregorian 1753 1 1..fromGregorian 2753 1 1]



