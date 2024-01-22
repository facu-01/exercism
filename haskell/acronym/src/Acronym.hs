{-# LANGUAGE OverloadedStrings #-}

module Acronym (abbreviate) where

import Control.Arrow
import Data.Char (toLower, toUpper)
import Data.Function
import qualified Data.Text as T

abbreviate :: T.Text -> T.Text
abbreviate xs =
  xs
    & T.unpack
    & filter (/= '\'')
    & T.pack
    & T.words
    & map (T.split (\y -> toLower y `notElem` ['a' .. 'z']))
    & concat
    & map
      ( T.unpack
          >>> ( \x ->
                  if not (all (`elem` ['A' .. 'Z']) x)
                    then foldl (\acc c -> if c `elem` ['A' .. 'Z'] then acc ++ ['|', c] else acc ++ [c]) "" x
                    else x
              )
      )
    & map (T.pack >>> T.split (== '|'))
    & concat
    & filter (/= "")
    & map (T.head >>> toUpper)
    & T.pack
