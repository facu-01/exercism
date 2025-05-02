module SecretHandshake (handshake) where

import Data.Function

intToBinary :: Int -> String
intToBinary 1 = "1"
intToBinary y = intToBinary d ++ show r
  where
    d = y `div` 2
    r = y `mod` 2

lol :: [Char] -> [String]
lol input = if "r" `elem` actions then tail $ reverse actions else actions
  where
    actionsMap = zip ["wink", "double blink", "close your eyes", "jump", "r"] $ reverse input
    actionsFilter = filter (\(_, v) -> v == '1') actionsMap
    actions = map fst actionsFilter

handshake :: Int -> [String]
handshake 0 = []
handshake n = n & intToBinary & lol
