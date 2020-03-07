module Lib
    ( someFunc
    , sayYo
    , maxCells
    , getNeighbors
    , wrapCell
    , pyramidRules
    , nextGeneration
    , isChild
    , cellularAutomata
    , clear
    , showRow
    , writeAt
    , goto
    , wait'
    ) where

someFunc :: IO ()
someFunc = putStrLn "someFunc"

sayYo :: String -> String
sayYo input = "Yo " ++ input ++ "!"

maxCells :: Int
maxCells = 100

type Cells = [Int]

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


-- make next generations of list
nextGeneration :: [Int] -> [Int]
nextGeneration ps = filter (isChild ps) [1..maxCells] 

isChild :: [Int] -> Int -> Bool
isChild ps c = pyramidRules [ elem a ps | a <- getNeighbors c ]

cellularAutomata :: [Int] -> IO ()
cellularAutomata ns = do clear
                         showRow ns
                         wait' 500000
                         cellularAutomata (nextGeneration ns)

clear :: IO ()
clear = putStr "\ESC[2J"

showRow :: [Int] -> IO ()
showRow cs = sequence_ [writeAt p "#" | p <- cs]

writeAt :: Int -> String -> IO ()
writeAt p xs = do goto p
                  putStr xs

-- goto (x) = putStr ("\ESC[" ++  show x ++ "H")

goto :: Int -> IO ()
goto x = putStr ("\ESC[" ++ show 1 ++ ";" ++ show x ++ "H")

wait' :: Int -> IO ()
wait' n = sequence_ [return () | _ <- [1..n]]