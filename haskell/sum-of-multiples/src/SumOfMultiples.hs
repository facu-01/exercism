module SumOfMultiples (sumOfMultiples) where

import Data.Function
import Data.List

sumOfMultiples :: [Integer] -> Integer -> Integer
sumOfMultiples factors limit = [x * y | x <- factors, y <- [1 .. limit], x * y < limit] & nub & sum