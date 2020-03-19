module Main where

import Lib
import GameOfLifeLib

main :: IO ()
main = do
  print "Enter the total number of cells to display."
  cellsWidthStr <- getLine
  let cellsWidth = (read cellsWidthStr :: Int)

  print "Enter a rule number 0..255"
  numberStr <- getLine
  let rules = reverse powersetRules 
  let rule = (rules!!(read numberStr :: Int))

  print "Enter a seed number 0..7"
  seedStr <- getLine
  let seeds = powersetSeedNum 
  let seed = (seeds!!(read seedStr :: Int))

  clear
  -- cellularAutomata' (map (80+) seed) rule
  cellularAutomata' (map ((div cellsWidth 2)+) seed) rule cellsWidth
  
  -- print ("hello" ++ name)
  -- print "What is your favorite number?"
  -- numberStr <- getLine
  -- print "Let's add 5!"
  -- print $ (+5) (read numberStr :: Int) 