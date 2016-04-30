module Main where

import System.Environment
import LispParser

main :: IO ()
main = do
	args <- getArgs
	putStrLn $ readExpr $ args !! 0


data LispVal = Atom String
						 | List [LispVal]
						 | DottedList [LispVal] LispVal
						 | Number Integer
						 | String String
						 | Bool Bool
