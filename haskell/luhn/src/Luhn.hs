{-# LANGUAGE OverloadedStrings #-}

module Luhn (isValid) where

import Control.Arrow
import Data.Function

isValid :: String -> Bool
isValid n
  | length clean <= 1 = False
  | otherwise =
      clean
        & (\xs -> [read [x] :: Integer | x <- xs])
        & (reverse >>> zip [1 ..])
        & map (\(i, x) -> if even i then if (x * 2) > 9 then (x * 2) - 9 else x * 2 else x)
        & sum
        & (\x -> x `mod` 10 == 0)
  where
    clean = filter (\x -> x /= ' ' && x `elem` ['0' .. '9']) n
