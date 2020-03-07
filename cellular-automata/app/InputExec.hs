module Main where

import Lib
import GameOfLifeLib

main :: IO ()
main = do
  print "Hello, what is your name?"
  name <- getLine
  print ("hello" ++ name)
  print "What is your favorite number?"
  numberStr <- getLine
  print "Let's add 5!"
  print $ (+5) (read numberStr :: Int) 