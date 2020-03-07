module Lib
    ( maxCells
    , seed
    , wrapCell
    , getNeighbors
    , pyramidRules
    , nextGeneration
    , isChild
    , cellularAutomata
    , clear
    , showRow
    , writeAt
    , wait'
    ) where

maxCells :: Int
maxCells = 160

-- add type signature
seed=[5]

wrapCell :: Int -> Int
wrapCell x = ((x-1) `mod` maxCells)  + 1

-- get neighbors 
getNeighbors :: Int -> [Int] 
getNeighbors n = map wrapCell [n-1, n, n+1]

-- use pattern matching with 2^3 rule to output true or false 
pyramidRules :: [Bool] -> Bool
pyramidRules [True, True, True] = False
pyramidRules [True, True, False] = True
pyramidRules [True, False, True] = False
pyramidRules [True, False, False] = True
pyramidRules [False, True, True] = True
pyramidRules [False, True, False] = False
pyramidRules [False, False, True] = True
pyramidRules [False, False, False] = False

-- write tests
-- make next generations of list
nextGeneration :: [Int] -> [Int]
nextGeneration ps = filter (isChild ps) [1..maxCells] 

-- write tests
isChild :: [Int] -> Int -> Bool
isChild ps c = pyramidRules [ elem a ps | a <- getNeighbors c ]

-- write tests
-- take out commprehsion and put in separate function for testing purposes
-- hasNeighbors :: [Int] -> Int -> [Bool]
-- hasNeighbors = undefined


cellularAutomata :: [Int] -> IO ()
cellularAutomata ns = do 
  putStr "\n"
  showRow ns
  wait' 100000000
  cellularAutomata (nextGeneration ns)

clear :: IO ()
clear = putStr "\ESC[2J"

showRow :: [Int] -> IO ()
showRow cs = sequence_ [writeAt p "#" | p <- cs]

writeAt :: Int -> String -> IO ()
writeAt p xs = do 
  putStr "\ESC[s"
  putStr ("\ESC[" ++ show p ++ "C")
  putStr xs
  putStr "\ESC[u"

wait' :: Int -> IO ()
wait' n = sequence_ [return () | _ <- [1..n]]