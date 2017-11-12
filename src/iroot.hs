
module Iroot where

iroot :: (Floating b, Integral a, RealFrac b) => b -> b -> a
iroot k n = floor . exp $ 1/k * log n
