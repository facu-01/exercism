module Phone (number) where

import Data.Function

clearDigits :: String -> String
clearDigits = filter (\x -> x `elem` ['0' .. '9'])

clearCountryCode :: String -> Maybe String
clearCountryCode phone
  | lPhone `notElem` [10, 11] = Nothing
  | countryCode /= '1' = Nothing
  | not areaOk = Nothing
  | otherwise = Just normalizedPhone
  where
    lPhone = length phone
    countryCode = if lPhone == 11 then head phone else '1'
    normalizedPhone = if lPhone == 11 then tail phone else phone
    areaOk =
      [ head normalizedPhone,
        normalizedPhone !! 3
      ]
        & all (\x -> x `elem` ['2' .. '9'])

number :: String -> Maybe String
number xs = clearCountryCode phone
  where
    phone = clearDigits xs
