-- Starting with 1 and spiralling anticlockwise in the following way, a square spiral with side length 7 is formed.
--
-- 37 36 35 34 33 32 31
-- 38 17 16 15 14 13 30
-- 39 18  5  4  3 12 29
-- 40 19  6  1  2 11 28
-- 41 20  7  8  9 10 27
-- 42 21 22 23 24 25 26
-- 43 44 45 46 47 48 49
--
-- It is interesting to note that the odd squares lie along the bottom right diagonal, but what is more interesting is that 8 out of the 13 numbers lying along both diagonals are prime; that is, a ratio of 8/13 ≈ 62%.
--
-- If one complete new layer is wrapped around the spiral above, a square spiral with side length 9 will be formed. If this process is continued, what is the side length of the square spiral for which the ratio of primes along both diagonals first falls below 10%?
--
-- Reflexion:
-- if n is the side length of the square spiral. The numbers at each 'coin' are
--
-- 1 -> 1
-- 2 -> 3 5 7 9
-- 3 -> 13 17 21 25
-- ...
--
-- The rule is
-- (last_max_number + n.(size-1) | n in [1..4])
-- examples:
--      last_max_number=1
--      size = 3
--      1+2 = 3, 1+2*2=5, 1+3*2=7, 1+4*2=9
--
--      last_max_number=9
--      size=5
--      9+4=13, 9+2*4=17, 9+3*4=21, 9+4*4=25

import Prime

next_four_numbers :: (Num a) => a -> a -> [a]
next_four_numbers n size = map (\p -> n + p*(size-1)) [1,2,3,4]
nextState (prev,size) = (next_four_numbers (last prev) size, size+2)
spiral = concat $ map fst $ iterate nextState ([1],3)
diag_primes = map is_prime spiral

ratio_func (x:xs) (p,q) = (p,q):(ratio_func xs b)
    where b = if x then (p+1,q+1) else (p,q+1)

ratios = ratio_func diag_primes (0,0)

takeNth n p (x:xs) = if n == p 
                     then x:takeNth n    1  xs
                     else   takeNth n (p+1) xs

-- takeWhile (>0.1) (map fst $ takeNth 4 4 ratios)

main = do
        -- putStrLn $ show $ firsts_spiral_numbers n
        putStrLn $ show $ take (4*n+1) spiral
        putStrLn $ show $ take (4*n+1) diag_primes
        putStrLn $ show $ take 10 $ takeNth 4 4 spiral
        -- putStrLn $ show $ tmp
        putStrLn $ show $ res
        putStrLn $ show $ ((res-1)/2) + 1 + 2
        where 
            n=3
            rat=0.1
            tmp = takeWhile (\(p,q) -> (q < 2) || (p/q > rat) ) $ takeNth 4 3 ratios
            (_,res) = last $ tmp

