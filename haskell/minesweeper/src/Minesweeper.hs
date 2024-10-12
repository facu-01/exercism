module Minesweeper (annotate) where

import Data.Char (intToDigit)
import Data.Function

type CellCoord = (Int, Int) -- x, y

type Board = [String]

safeGetValue :: [a] -> Int -> Maybe a
safeGetValue l i
  | null l = Nothing
  | i >= length l = Nothing
  | i < 0 = Nothing
  | otherwise = Just (l !! i)

getCellValue :: Board -> CellCoord -> Int
getCellValue board (x, y) = if isMine then 1 else 0
  where
    row = safeGetValue board x
    value = row >>= (\r -> safeGetValue r y)
    isMine = value == Just '*'

calcCellValue :: Board -> CellCoord -> Char
calcCellValue board (x, y) = if value > 0 then intToDigit value else ' '
  where
    coords = [(x1, y1) | x1 <- [(x - 1) .. (x + 1)], y1 <- [(y - 1) .. (y + 1)], (x1, y1) /= (x, y)]
    value = map (getCellValue board) coords & sum

annotate :: Board -> Board
annotate board =
  zip [0 ..] board
    & map (\(x, r) -> map (\(y, v) -> if v == '*' then v else calcCellValue board (x, y)) (zip [0 ..] r))
