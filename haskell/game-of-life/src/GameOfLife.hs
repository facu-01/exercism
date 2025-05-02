module GameOfLife (tick) where

import Control.Arrow
import Data.Function

type CellCoord = (Int, Int) -- x, y

type Board = [[Int]]

safeGetValue :: [a] -> Int -> Maybe a
safeGetValue l i
  | null l = Nothing
  | i >= length l = Nothing
  | i < 0 = Nothing
  | otherwise = Just (l !! i)

getCellValue :: Board -> CellCoord -> Int
getCellValue board (x, y) = if isAlive then 1 else 0
  where
    row = safeGetValue board x
    value = row >>= (\r -> safeGetValue r y)
    isAlive = value == Just 1

getNewCelVal :: Int -> Int -> Int
getNewCelVal cellValue adjCellsLive
  | cellLive && adjCellsLive `elem` [2, 3] = 1
  | not cellLive && adjCellsLive == 3 = 1
  | otherwise = 0
  where
    cellLive = cellValue == 1

calcCellValue :: Board -> CellCoord -> Int
calcCellValue board (x, y) = getNewCelVal currentValue adjacentsCellsLive
  where
    adjacentsCells = [getCellValue board (x1, y1) | x1 <- [(x - 1) .. (x + 1)], y1 <- [(y - 1) .. (y + 1)], (x1, y1) /= (x, y)]
    adjacentsCellsLive = length $ filter (== 1) adjacentsCells
    currentValue = getCellValue board (x, y)

-- anotateBoard :: Board -> a
anotateBoard :: Board -> Int -> [[(Int, Int)]]
anotateBoard [] _ = []
anotateBoard (x : xs) c = anotatedRow : anotateBoard xs (c + 1)
  where
    row = zip [0 ..] x & map fst :: [Int]
    anotatedRow = map (\y -> (c, y)) row

tick :: Board -> Board
tick board = map (map (calcCellValue board)) anotatedBoard
  where
    anotatedBoard = anotateBoard board 0
