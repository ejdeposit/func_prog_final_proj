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

-- generalRule :: [Bool] -> Bool
-- generalRule xs ys = case ys of [True, True, True]    -> xs!!0
--                                [True, True, False]   -> xs!!1
--                                [True, False, True]   -> xs!!2
--                                [True, False, False]  -> xs!!3
--                                [False, True, True]   -> xs!!4
--                                [False, True, False]  -> xs!!5
--                                [False, False, True]  -> xs!!6
--                                [False, False, False] -> xs!!7


--   where result1 = False
--         result2 = True
--         result3 = False
--         result4 = True
--         result5 = True
--         result6 = False
--         result7 = True
--         result8 = False)

-- make way to create any rule


-- add rules function that uses cases

-- add rules function using if else

hasNeighbors :: [Int] -> Int -> [Bool]
hasNeighbors cs c = [ elem a cs | a <- getNeighbors c ]

-- write tests
isChild :: [Int] -> Int -> Bool
isChild cs c = pyramidRules $ hasNeighbors cs c

-- write tests
-- make next generations of list
nextGeneration :: [Int] -> [Int]
nextGeneration ps = filter (isChild ps) [1..maxCells] 

-- no tests for following IO function 
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