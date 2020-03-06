module Lib
    ( someFunc
    , sayYo
    , maxCells
    , getNeighbors
    , wrapCell
    ) where

someFunc :: IO ()
someFunc = putStrLn "someFunc"

sayYo :: String -> String
sayYo input = "Yo " ++ input ++ "!"

maxCells :: Int
maxCells = 10

type Cells = [Int]

getNeighbors :: Int -> [Int] 
getNeighbors n = map wrapCell [n-1, n, n+1]

wrapCell :: Int -> Int
wrapCell x = ((x-1) `mod` maxCells)  + 1

-- 2^3 rule


