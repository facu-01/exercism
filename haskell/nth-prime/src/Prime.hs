module Prime (nth) where

import Control.Arrow
import Data.Function
import Data.List (elemIndex)

primesToN :: Int -> [Int]
primesToN 1 = [1, 0]
primesToN 2 = [2, 1, 0]
primesToN x
  | notPrime = primes
  | otherwise = x : primes
  where
    primes = primesToN (x - 1)
    notPrime = any (\y -> x `mod` y == 0) primes

nth :: Int -> Maybe Integer
nth n = elemIndex n primes & fmap toInteger & fmap (+ 1)
  where
    primes = (primesToN >>> reverse) n
