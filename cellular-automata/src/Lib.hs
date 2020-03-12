module Lib
    ( maxCells
    , seed
    , wrapCell
    , getNeighbors
    , pyramidRules
    , nextGeneration
    , isChild
    , hasNeighbors
    , cellularAutomata
    , clear
    , showRow
    , writeAt
    , wait'
    , pyramidRules'
    , genRules
    , cellularAutomata'
    , powersetRules
    ) where

import Data.List (permutations)

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

-- [False, True, False, True, True, False, True, False]
-- general rulle should take list of bools and use where statment
pyramidRules' :: [Bool] -> Bool
pyramidRules' = (\x -> case x of [True, True, True]    -> False
                                 [True, True, False]   -> True
                                 [True, False, True]   -> False
                                 [True, False, False]  -> True
                                 [False, True, True]   -> True
                                 [False, True, False]  -> False
                                 [False, False, True]  -> True
                                 [False, False, False] -> False)

hasNeighbors :: [Int] -> Int -> [Bool]
hasNeighbors cs c = [ elem a cs | a <- getNeighbors c ]

-- write tests
isChild :: [Int] -> Int -> Bool
isChild cs c = pyramidRules $ hasNeighbors cs c

-- write tests
-- make next generations of list
nextGeneration :: [Int] -> [Int]
nextGeneration ps = filter (isChild ps) [1..maxCells] 

----------------------------------------------------------------------
--                           print functions 
----------------------------------------------------------------------
-- no tests for following IO function 

-- take seed of first row of cells
cellularAutomata :: [Int] -> IO ()
cellularAutomata ns = do 
  putStr "\n"
  showRow ns
  wait' 100000000
  cellularAutomata (nextGeneration ns)

clear :: IO ()
clear = putStr "\ESC[2J"

showRow :: [Int] -> IO ()
showRow cs = sequence_ [writeAt p shapeString | p <- cs]

shapeString :: String 
shapeString = '\9608':[]

writeAt :: Int -> String -> IO ()
writeAt p xs = do 
  putStr "\ESC[s"
  putStr ("\ESC[" ++ show p ++ "C")
  putStr xs
  putStr "\ESC[u"

wait' :: Int -> IO ()
wait' n = sequence_ [return () | _ <- [1..n]]


----------------------------------------------------------------------
--                      functions for user input 
----------------------------------------------------------------------

-- takes list of bools as input and returns rules function
genRules :: [Bool] -> [Bool] -> Bool
genRules = (\ys -> (\xs -> case xs of [True, True, True]    -> ys!!0
                                      [True, True, False]   -> ys!!1
                                      [True, False, True]   -> ys!!2
                                      [True, False, False]  -> ys!!3
                                      [False, True, True]   -> ys!!4
                                      [False, True, False]  -> ys!!5
                                      [False, False, True]  -> ys!!6
                                      [False, False, False] -> ys!!7))
                                     
-- from text book
filterM :: Monad m => (a -> m Bool) -> [a] -> m [a]
filterM p [] = return []
filterM p (x:xs) = do b <- p x
                      ys <- filterM p xs
                      return (if b then x:ys else ys)

-- from text book
powerset (x:xs) = filterM (\x -> [True, False]) (x:xs)

-- generates power set of [1..8]
powersetRulesNum = powerset [1,2,3,4,5,6,7,8]

-- takes list of numbers and converts to list of trues and falses
numsToBools xs = [ elem a xs | a <- [1..8]]

-- generates all rules
powersetRules = map numsToBools powersetRulesNum

cellularAutomata' :: [Int] -> [Bool] -> IO ()
cellularAutomata' cs rs = do 
  putStr "\n"
  showRow cs
  wait' 100000000
  cellularAutomata' (nextGeneration' cs rs) rs

nextGeneration' :: [Int] -> [Bool] -> [Int]
nextGeneration' ps rs = filter (isChild' ps rs) [1..maxCells] 

-- rs has to come before c can be the last missing argument
isChild' :: [Int] -> [Bool] -> Int -> Bool
isChild' cs rs c = (genRules rs) $ hasNeighbors cs c