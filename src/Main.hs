{-# LANGUAGE OverloadedStrings #-}
module Main where

import System.Environment
import Web.Scotty

import Routes

-- This assumes that you'd do something along the lines of:
-- -p 3001, --port 3001, really any argument followed by the desired port number
getPort :: [String] -> Int
getPort args = if null args then 3000
                else (stringToInt (args!!1))

stringToInt :: String -> Int
stringToInt number = read number :: Int

main :: IO ()
main = do
  args <- getArgs
  let port = getPort args
  putStrLn "Starting Server..."
  scotty port routes
