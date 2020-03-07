module Main where

import Lib
import GameOfLifeLib

main :: IO ()
main = do clear
          cellularAutomata [80] 
