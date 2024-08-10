module CryptoSquare (encode) where

import Control.Arrow
import Data.Char (toLower)
import Data.Function
import Data.List (intercalate, intersperse, transpose)
import qualified Data.Text  as T
import GHC.Num (integerSqr)

fillWith :: a -> Int -> [a] -> [a]
fillWith c n l
  | length l > n = l
  | otherwise = fillWith c n (l ++ [c])

getNCols :: Int -> Int
getNCols l = columns
  where
    root = (fromIntegral >>> sqrt) l
    columns = ceiling root

encode :: String -> String
encode xs = unwords transposed
  where
    clean = xs & map toLower & filter (`elem` (['a' .. 'z'] ++ ['0' .. '9']))
    columns = clean & length & getNCols
    chunks = clean & (T.pack >>> T.chunksOf columns) & map (T.unpack >>> fillWith ' ' columns)
    transposed = chunks & (transpose >>> filter (all (== ' ') >>> not))
