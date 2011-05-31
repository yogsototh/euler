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

special_numbers 1 = take 300 primes
-- special_numbers n = nub $ flatten $ filter (\x -> traceShow x are_concat_primes x) $ subsets n (special_numbers (n-1))
special_numbers n = nub $ flatten $ filter are_concat_primes $ subsets n (special_numbers (n-1))
    where
        flatten [] = []
        flatten ([]:ys) = flatten ys
        flatten ((x:xs):ys) = x:flatten (xs:ys)

subsets :: Integer -> [a] -> [[a]]
subsets 0 _ = [[]]
subsets n [] = []
subsets n (x:xs) = [x:ys | ys <- subsets (n-1) xs ] ++ subsets n xs

main = do
        putStrLn $ show $ are_concat_primes [3,7,109,673]
        putStrLn $ show $ numbers
        putStrLn $ show $ result
        where
            numbers = take 5 $ special_numbers 5
            result  = sum numbers
