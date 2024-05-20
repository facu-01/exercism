module Clock (addDelta, fromHourMin, toString) where

import Data.Function
import Text.Printf

data Clock = Clock Int Int
  deriving (Eq)

fromHourMin :: Int -> Int -> Clock
fromHourMin hour min = Clock parsedHour parsedMin
  where
    hourPlusMinsOver = hour + div min 60
    parsedHour = mod hourPlusMinsOver 24
    parsedMin = mod min 60

toString :: Clock -> String
toString (Clock hour min) = parsedHour ++ ":" ++ parsedMin
  where
    parsedHour = printf "%02d" hour
    parsedMin = printf "%02d" min

addDelta :: Int -> Int -> Clock -> Clock
addDelta hour min (Clock prevHour prevMin) = Clock newHourRollOver newMinRollOver
  where
    newMin = prevMin + min
    newHour = prevHour + hour + div newMin 60
    newHourRollOver = mod newHour 24
    newMinRollOver = mod newMin 60