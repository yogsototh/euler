#!/usr/bin/env stack
{- stack script
   --resolver lts-13.24
   --install-ghc
   --package arithmoi
-}

{-
Consider the fraction, n/d, where n and d are positive integers. If n<d and
HCF(n,d)=1, it is called a reduced proper fraction.

If we list the set of reduced proper fractions for d ≤ 8 in ascending order of
size, we get:

1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 7/8

It can be seen that there are 21 elements in this set.

How many elements would be contained in the set of reduced proper fractions for
d ≤ 1,000,000?
-}
{-# LANGUAGE NoImplicitPrelude #-}
module Euler072 where

import Protolude

import Math.NumberTheory.Primes

reducedProper :: Integer -> [Integer]
reducedProper d = do
  let pf = map fst $ factorise d
  x <- [1..d]
  guard (not (any (\p -> x `rem` p == 0) pf))
  return x

-- Naive solution, took ages
nbFractions :: Integer -> Int
nbFractions d = foldl' (+) 0 (map (traceShowId . length . reducedProper . traceShowId) [2..d])

solutionSlow = nbFractions 1000000

-- Write a list of all factors
factors = concatMap (\(x,n) -> replicate n x) . factorise

-- phi, Euler's totient function
-- https://en.wikipedia.org/wiki/Euler%27s_totient_function
phi n
  | isPrime n = n-1
  | otherwise = prodPhi (factors n)
  where
    prodPhi [a] = a-1
    prodPhi (a:b:t)
      | a == b = a * prodPhi (b:t)
      | otherwise = (a - 1) * prodPhi (b:t)

-- less than 5s
solution = let n = 1000000 in sum $ map phi [2..n]
