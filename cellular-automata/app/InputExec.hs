module Main where

import Lib
import GameOfLifeLib

main :: IO ()
main = do
  print "Enter a number 0..255"
  numberStr <- getLine
  let rules = powersetRules 
  let rule = (rules!!(read numberStr :: Int))
  clear
  cellularAutomata' [80] rule
  
  -- print ("hello" ++ name)
  -- print "What is your favorite number?"
  -- numberStr <- getLine
  -- print "Let's add 5!"
  -- print $ (+5) (read numberStr :: Int) 