module DNA (toRNA) where

import qualified Data.Map as Map

nucleotideMap :: Map.Map Char Char
nucleotideMap =
  Map.fromList
    [ ('G', 'C'),
      ('C', 'G'),
      ('T', 'A'),
      ('A', 'U')
    ]

toRNA :: String -> Either Char String
toRNA "" = Right ""
toRNA (x : xs) = case Map.lookup x nucleotideMap of
  Nothing -> Left x
  Just n -> (n :) <$> toRNA xs