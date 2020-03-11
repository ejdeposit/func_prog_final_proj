module Main where

import Test.Tasty
import Test.Tasty.HUnit

import Lib
import GameOfLifeLib

main :: IO ()
main = do
  defaultMain (testGroup "Some of our Library Tests" [wrapTest, wrapTest2, wrapTest3, wrapTest4, getNeighborsTest1, getNeighborsTest2, getNeighborsTest3, hasNeighborsTest0 ,hasNeighborsTest1, hasNeighborsTest2, hasNeighborsTest3, hasNeighborsTest4, hasNeighborsTest5, pyramidRulesTest1, genRuleTest1])

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

hasNeighborsTest0 :: TestTree
hasNeighborsTest0 = testCase "hasNeighbors 2 [] returns all False"
  (assertEqual "hasNeighbors 2 [] returns all False" [False,False,False] (hasNeighbors [] 2))

hasNeighborsTest1 :: TestTree
hasNeighborsTest1 = testCase "hasNeighbors 2 [1,2 3] returns all True"
  (assertEqual "hasNeighbors 2 [1,2 3] returns all True" [True,True,True] (hasNeighbors [1,2,3] 2))

hasNeighborsTest2 :: TestTree
hasNeighborsTest2 = testCase "hasNeighbors 1 [maxCells,1 2] returns all True"
  (assertEqual "hasNeighbors 1 [maxCells,1 2] returns all True" [True,True,True] (hasNeighbors [maxCells,1, 2] 1))

hasNeighborsTest3 :: TestTree
hasNeighborsTest3 = testCase "hasNeighbors 1 [1 2] returns all [False,True,True]"
  (assertEqual "hasNeighbors 1 [1 2] returns all [False,True,True]" [False,True,True] (hasNeighbors [1, 2] 1))
  
hasNeighborsTest4 :: TestTree
hasNeighborsTest4 = testCase "hasNeighbors [] maxCells returns all False"
  (assertEqual "hasNeighbors [] maxCells returns all False" [False,False,False] (hasNeighbors [] maxCells))

hasNeighborsTest5 :: TestTree
hasNeighborsTest5 = testCase "hasNeighbors [maxCells-1,maxCells,1] maxCells returns all True"
  (assertEqual "hasNeighbors [maxCells-1,maxCells,1] maxCells returns all True" [True,True,True] (hasNeighbors [maxCells-1,maxCells,1] maxCells))

pyramidRulesTest1 :: TestTree
pyramidRulesTest1 = testCase "same result as old pyramidrule func"
  (assertEqual "same result as old pyramidrule func" False (pyramidRules' [True, True, True]))

-- [False, True, False, True, True, False, True, False]
genRuleTest1 :: TestTree
genRuleTest1 = testCase "same result as frist pyramid func when given [f,t,f,t,t,f,t,f]"
  (assertEqual "same result as frist pyramid func when given [f,t,f,t,t,f,t,f]" False (genRules [False, True, False, True, True, False, True, False] [True, True, True]))

-- sayYoTest :: TestTree
-- sayYoTest = testCase "Testing sayYo"
--   (assertEqual "Should say Yo to Friend!" "Yo Friend!" (sayYo "Friend"))

-- add5Test :: TestTree
-- add5Test = testCase "Testing add5"
--   (assertEqual "Should add 5 to get 10" 10 (add5 5))