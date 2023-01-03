{-# LANGUAGE ViewPatterns #-}

module Bob (responseFor) where

import Data.Text (Text)
import qualified Data.Text as T

(&) :: a -> (a -> c) -> c
(&) = flip ($)

responseFor :: Text -> Text
responseFor xs
  | silence = T.pack "Fine. Be that way!"
  | yelling && isQuestion = T.pack "Calm down, I know what I'm doing!"
  | yelling = T.pack "Whoa, chill out!"
  | isQuestion = T.pack "Sure."
  | otherwise = T.pack "Whatever."
  where
    silence = T.strip xs & T.null
    yelling = T.toUpper xs == xs && T.toLower xs /= xs
    isQuestion = T.strip xs & (\x -> T.last x == '?')
