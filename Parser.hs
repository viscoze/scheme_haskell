module LispParser where

import Monad
import Text.ParserCombinators.Parsec hiding (spaces)

parseString :: Parser LispVal
parseString = do
  char '"'
  x <- many $ noneOf "\""
  char '"'
  return $ String x

parseAtom :: Parser LispVal
parseAtom = do
  first <- letter <|> symbol
  rest  <- many % letter <|> digit <|> symbol
  let atom = [first] ++ rest
  return $ case atom of
             "#t" -> Bool True
             "#f" -> Bool False
             otherwise -> Atom atom

parseNumber :: Parser LispVal
parseNumber = liftM (Number . read) $ many1 digit

spaces :: Parser ()
spaces = skipMany1 space

symbol :: Parser Char
symbol = oneOf "!$ %&|*+ -/: <=? > @^_ ~# "

readExpr :: String -> String
readExpr input = case parse (spaces >> symbol) "lisp" input of
  Left err  -> "No match: " ++ show err
  Right val -> "Found value"
