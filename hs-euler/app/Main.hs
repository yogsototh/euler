#!/usr/bin/env stack
{- stack script
   --resolver lts-13.24
   --install-ghc
   --package arithmoi
-}

{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
module Main where

import Protolude

import System.Environment

import qualified Euler072

solution :: Int -> Maybe (IO ())
solution 72 = Just $ do putStr ("072: " :: Text); print Euler072.solution
solution _ = Nothing

solutions = [72]

readNumber :: [[Char]] -> Maybe Int
readNumber [] = Nothing
readNumber (s:args) = reads s & head & fmap fst

main :: IO ()
main = do
  nbParsed <- fmap readNumber getArgs
  case nbParsed of
    Just nb -> fromMaybe
                  (putErrText "I don't know the solution of this problem yet.")
                  (solution nb)
    Nothing -> solutions
               & map solution
               & map (fromMaybe (pure ()))
               & sequence_
