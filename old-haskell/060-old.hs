-- 
-- The primes 3, 7, 109, and 673, are quite remarkable. 
-- By taking any two primes and concatenating them in any order the result will always be prime. 
-- For example, taking 7 and 109, both 7109 and 1097 are prime. 
-- The sum of these four primes, 792, represents the lowest sum for a set of four primes with this property.
--
-- Find the lowest sum for a set of five primes for which any two primes concatenate to produce another prime.
--

-- Should use the following property
-- [x,y,z,t] special <=> [x,y,z] & [x,y,t] & [x,z,t] & [y,z,t] special


import Debug.Trace
import Data.List
import Prime

is_couple_prime x y = ( is_prime $ read $ strx ++ stry ) &&  (is_prime $ read $ stry ++ strx)
    where
        strx = show x
        stry = show y

first_concat_prime_with_list x [] = True
first_concat_prime_with_list x (y:ys) = is_couple_prime x y && first_concat_prime_with_list x ys

-- are_concat_primes [3,7,109,673] return true if number are primes
-- even with concat
are_concat_primes [] = True
are_concat_primes (x:xs) = (are_concat_primes xs) && first_concat_prime_with_list x xs

nb_elements=4

-- n=5 max=5 -> 12345
-- n=5 max=6 -> 12346, 12356, 12456, 13456, 23456
-- n=5 max=7 -> 12347, 12357, 12367, 12457, 12467...

-- n=1 max=1 -> 1
-- n=1 max=2 -> 2
-- n=1 max=3 -> 3
--
-- n=2 max=2 -> 12
-- n=2 max=3 -> 13, 23
-- n=2 max=4 -> 14, 24, 34
-- n=2 max=5 -> 15, 26, 35, 45
--
-- n=3 max=3 -> 123
-- n=3 max=4 -> 124, 134, 234
-- n=3 max=5 -> 125, 135, 235, 145, 245, 345  (n=2,max=2 ; n=2,max=3 ; n=2,max=4)++[5]

combination :: (Ord a) => Int -> a -> [a] -> [[a]]
combination 0 max list = []
combination n max (x:xs@(y:ys)) 
    | x>max             = []
    | n==1 && 
      x<=max && y>max   = [[x]]
    | otherwise         = ( map (\z -> x:z)  $ combination (n-1) max xs )
                            ++ combination n max xs

all_combinations n xs = foldr (++) [] $ map (\i -> traceShow i combination n (xs!!i) xs) [(n-1)..]

special_numbers 1 = primes
special_numbers n = nub $ flatten $ filter are_concat_primes $ all_combinations n $ special_numbers (n-1)
    where
        flatten [] = []
        flatten ([]:ys) = flatten ys
        flatten ((x:xs):ys) = x:(flatten ((xs):ys) )

main = do
        -- putStrLn $ show $ are_concat_primes [3,7,109,673]
        -- putStrLn $ show $ are_concat_primes [3,7,19,673]
        -- putStrLn $ show $ combination 5 5 [1..]
        -- putStrLn $ show $ take 40 $ all_combinations 5 primes
        putStrLn $ show $ result
        -- putStrLn ( "sum: " ++ (show $ sum result))
        where
            result = take 1 $ filter (\x -> traceShow x are_concat_primes [3,7,109,673,x]) primes
