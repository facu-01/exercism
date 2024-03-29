module Grains (square, total) where

square :: Integer -> Maybe Integer
square n
  | n <= 0 || n > 64 = Nothing
  | n == 1 = Just 1
  | otherwise = Just (2 ^ (n - 1))

total :: Integer
total = 18446744073709551615

-- total = 2 ^ (64 :: Integer)
