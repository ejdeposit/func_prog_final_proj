module Main where

import Test.Tasty
import Test.Tasty.HUnit

import Lib
import GameOfLifeLib

main :: IO ()
main = do
  defaultMain (testGroup "Some of our Library Tests" [sayYoTest, add5Test, wrapTest, wrapTest2, wrapTest3, wrapTest4, getNeighborsTest1, getNeighborsTest2, getNeighborsTest3])


sayYoTest :: TestTree
sayYoTest = testCase "Testing sayYo"
  (assertEqual "Should say Yo to Friend!" "Yo Friend!" (sayYo "Friend"))

add5Test :: TestTree
add5Test = testCase "Testing add5"
  (assertEqual "Should add 5 to get 10" 10 (add5 5))

wrapTest :: TestTree
wrapTest = testCase "wrapCell width+1 returns 1"
  (assertEqual "wrapCell width+1 returns 1" 1 (wrapCell $ maxCells+1))

wrapTest2 :: TestTree
wrapTest2 = testCase "wrapCell 1 returns 1"
  (assertEqual "wrapCell 1 returns 1" 1 (wrapCell 1))

wrapTest3 :: TestTree
wrapTest3 = testCase "wrap width returns width"
  (assertEqual "wrap width returns width" maxCells (wrapCell maxCells))

wrapTest4 :: TestTree
wrapTest4 = testCase "wrap 0 returns width"
  (assertEqual "wrap 0 returns width" maxCells (wrapCell 0))

getNeighborsTest1 :: TestTree
getNeighborsTest1 = testCase "neighbors of 2 are 1, 2, 3"
  (assertEqual "neighbors of 2 are 1, 2, 3" [1,2,3] (getNeighbors 2))

getNeighborsTest2 :: TestTree
getNeighborsTest2 = testCase "neighbors of 1 are maxCells, 1, 2"
  (assertEqual "neighbors of 1 are maxCells, 1, 2" [maxCells,1,2] (getNeighbors 1))

getNeighborsTest3 :: TestTree
getNeighborsTest3 = testCase "neighbors of max are max-1, max, 1"
  (assertEqual "neighbors of max are max-1, max, 1" [maxCells-1, maxCells, 1] (getNeighbors maxCells))
