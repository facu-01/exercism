module Triangle (rows) where

import Data.Maybe

safeAt :: [a] -> Int -> Maybe a
safeAt l i
  | i >= length l = Nothing
  | i < 0 = Nothing
  | otherwise = Just $ l !! i

calcValue :: Int -> [Integer] -> Integer
calcValue index prev = l + r
  where
    l = fromMaybe 0 $ safeAt prev $ index - 1
    r = fromMaybe 0 $ safeAt prev index

rows :: Int -> [[Integer]]
rows x
  | x <= 0 = []
  | x == 1 = [[1]]
  | otherwise = prevRows ++ [currentRow]
  where
    prevRows = rows (x - 1)
    prevRow = last prevRows
    rowIndexs = [0 .. (x - 1)]
    currentRow = map (`calcValue` prevRow) rowIndexs
