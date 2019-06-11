-- Consider quadratic Diophantine equations of the form:
-- 
-- x^2 – Dy^2 = 1
-- 
-- For example, when D=13, the minimal solution in x is 6492 – 13×1802 = 1.
-- 
-- It can be assumed that there are no solutions in positive integers when D is square.
-- 
-- By finding minimal solutions in x for D = {2, 3, 5, 6, 7}, we obtain the following:
-- 
--         32 – 2×22 = 1
--         22 – 3×12 = 1
--         92 – 5×42 = 1
--         52 – 6×22 = 1
--         82 – 7×32 = 1
-- 
-- Hence, by considering minimal solutions in x for D ≤ 7, the largest x is obtained when D=5.
-- 
-- Find the value of D ≤ 1000 in minimal solutions of x for which the largest value of x is obtained.

import Control.Monad
import Data.List
import Data.Maybe

-- import Debug.Trace

-- -- Brute force search
-- isqrt = floor . sqrt . fromIntegral
-- 
-- isSquare d = (isqrt d)^2 == d
-- 
--
-- 
-- hasSolution d x =
--     let y = isqrt (( x^2 - 1 ) `div` d)
--     in x^2 - (y^2)*d == 1
-- 
-- phead [] = -2 
-- phead (x:xs) = x
-- 
-- sol d = if isSquare d
--            then -1 
--            else phead $ filter (hasSolution d) [2..10000000]

-- Using Pell equation formulae
-- http://fr.wikipedia.org/wiki/Équation_de_Pell-Fermat#Cas_x.C2.B2-ny.C2.B2_.3D_1

isqrt = floor . sqrt . fromIntegral
isSquare d = (isqrt d)^2 == d

ratFracSqrt :: Integer -> Integer -> Integer -> [(Integer,(Integer,Integer,Integer))]
ratFracSqrt a b c =
    let m = a - (b^2)
        fa = fromInteger a :: Float
        fb = fromInteger b :: Float
        fc = fromInteger c :: Float
        fm = fromInteger m :: Float
        x = floor $ (fc * ((sqrt fa) - fb))/ (fm)
        h = c
        i = -1 *  ( c*b + x*m )
        j = m
    in 
        if ( x^2 == a ) 
           then (0,(0,0,0)):ratFracSqrt a b c
           else if (m `rem` h /= 0) 
                then error "Bad division" 
                else (x,(a,b,c)):ratFracSqrt a (i `div` h) (j `div` h)

ratFracPeriodLength s =
    let 
        sig = head $ tail s
        index = fromJust $ elemIndex sig $( tail $ tail s )
    in if head s == (0,(0,0,0))
          then 0
          else index + 1

-- The "reduite" is the number p/q = a_0 + ( 1/ (a_1 + ...) )
reduite (x:[]) = (x,1)
reduite (x:xs) = let 
                   precalc = reduite xs
                   num = fst precalc
                   den = snd precalc
                 in
                   (x * num + den, num)

-- Solution for x^2 - dy^2 = 1
sol d = let
            rfs = ratFracSqrt d 0 d
            len = ratFracPeriodLength rfs
            usedLen = if len `rem` 2 == 0 then (len) else (2*len)
        in
            if isSquare d 
               then -1 
               else fst $ reduite $ take usedLen $ map fst rfs
               -- else fst $ reduite $ trace (show $ take usedLen $ map fst rfs) (take usedLen $ map fst rfs)

main = let 
            m = 1000
            lst = map sol [2..m] 
            maxelem = foldl' (\x y -> if x>y then x else y) 0 lst
       in do
           forM_ [2..m] (\d -> do putStr $ (show d) ++ " -> "; print $ lst !! (fromIntegral d-2))
           putStr "Maximum value: "
           print maxelem
           putStr "Maximum D: "
           print $ 2 + (fromJust $ elemIndex maxelem lst)
