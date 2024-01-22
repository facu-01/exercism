module DNA (nucleotideCounts, Nucleotide (..)) where

import Data.Function
import qualified Data.Map as Map
import Data.Maybe (fromJust, isJust)
import Text.Read (readMaybe)

data Nucleotide = A | C | G | T deriving (Eq, Ord, Show, Read)

parseNucleotide :: Char -> Maybe Nucleotide
parseNucleotide n = readMaybe [n]

nucleotideCounts :: String -> Either String (Map.Map Nucleotide Int)
nucleotideCounts xs =
  map parseNucleotide xs
    & ( \parsed ->
          if all isJust parsed
            then map fromJust parsed & foldl (\m n -> Map.insertWith (+) n 1 m) Map.empty & Right
            else Left "INVALID"
      )
