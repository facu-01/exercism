module PerfectNumbers (classify, Classification (..)) where

data Classification = Deficient | Perfect | Abundant deriving (Eq, Show)

factors :: Int -> [Int]
factors x = [f | f <- [1 .. x], x `mod` f == 0, f < x]

classify :: Int -> Maybe Classification
classify x
  | x < 1 = Nothing
  | x == sumAliq = Just Perfect
  | x < sumAliq = Just Abundant
  | x > sumAliq = Just Deficient
  | otherwise = Nothing
  where
    sumAliq = sum $ factors x
