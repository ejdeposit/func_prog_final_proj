module Main where

import Test.Tasty
import Test.Tasty.HUnit

import Lib
import GameOfLifeLib

main :: IO ()
main = do
  defaultMain (testGroup "Some of our Library Tests" [sayYoTest, add5Test, wrapTest, wrapTest2, wrapTest3, wrapTest4])


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
