module CollatzConjecture (collatz) where

(&) :: a -> (a -> c) -> c
(&) = flip ($)

collatz :: Integer -> Maybe Integer
collatz n
  | n <= 0 = Nothing
  | n == 1 = Just 0
  | even n = collatz (n `div` 2) & fmap (+ 1)
  | otherwise = collatz (n * 3 + 1) & fmap (+ 1)

-- >>> collatz 12
-- 9
