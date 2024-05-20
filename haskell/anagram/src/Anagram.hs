module Anagram (anagramsFor) where

import Data.Char (toLower)
import Data.Function
import Data.List (sort)

anagramsFor :: String -> [String] -> [String]
anagramsFor xs xss =
  filter (\x -> map toLower x /= map toLower xs) xss
    & filter (\x -> sort (map toLower x) == sort (map toLower xs))
