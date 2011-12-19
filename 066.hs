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

isqrt = floor . sqrt . fromIntegral

isSquare d = (isqrt d)^2 == d

hasSolution d x =
    let y = isqrt (( x^2 - 1 ) `div` d)
    in x^2 - (y^2)*d == 1

phead [] = -2 
phead (x:xs) = x

sol d = if isSquare d
           then -1 
           else phead $ filter (hasSolution d) [2..1000000]

main = let 
            lst = map sol [2..1000] 
            maxelem = foldl' (\x y -> if x>y then x else y) 0 lst
       in do
           forM_ [2..1000] (\d -> do putStr $ (show d) ++ " -> "; print $ lst !! d)
           print maxelem
           print $ elemIndex maxelem lst
