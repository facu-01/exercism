module Prime (nth) where

import Control.Arrow
import Data.Function
import Data.List (elemIndex)

nextPrime :: Int -> Int
nextPrime 1 = 2
nextPrime n
  | notPrime = nextPrime (n + 1)
  | otherwise = n + 1
  where
    notPrime = any (\y -> (n + 1) `mod` y == 0) [2 .. n]

nth :: Int -> Maybe Integer
nth n
  | n == 0 = Nothing
  | n == 1 = Just 2
  | otherwise = nth (n - 1) & fmap (fromInteger >>> nextPrime >>> toInteger)
