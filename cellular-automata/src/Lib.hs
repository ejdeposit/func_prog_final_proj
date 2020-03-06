module Lib
    ( someFunc
    , sayYo
    , maxCells
    , getNeighbors
    , wrapCells
    ) where

someFunc :: IO ()
someFunc = putStrLn "someFunc"

sayYo :: String -> String
sayYo input = "Yo " ++ input ++ "!"

maxCells :: int
maxCells = 10

type Cells = [Int]

getNeighbors :: Int -> [Int] 
getNeighbors n = map wrapCells [n-1, n, n+1]

wrapCell :: Int -> Int
wrapCells x = ((x-1) `mod` maxCells)  + 1

-- 2^3 rule


