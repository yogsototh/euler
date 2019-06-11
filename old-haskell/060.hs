-- Problem 60
-- 02 January 2004
--
-- The primes 3, 7, 109, and 673, are quite remarkable. By taking any two primes and concatenating them in any order the result will always be prime. For example, taking 7 and 109, both 7109 and 1097 are prime. The sum of these four primes, 792, represents the lowest sum for a set of four primes with this property.
--
-- Find the lowest sum for a set of five primes for which any two primes concatenate to produce another prime.
--

import Prime

numOfDigits x
    | x < 10 = 1
    | x < 100 = 2
    | x < 1000 = 3
    | x < 10000 = 4
    | x < 100000 = 5
    | x < 1000000 = 6
    | x < 10000000 = 7
--    | otherwise = truncate (logBase 10 x)

-- equivalent but faster than "read (show x ++ show y)"
concatNumbers :: Int -> Int -> Int
concatNumbers x y = (10^numOfDigits y)*x + y

areConcatPrime :: [Int] -> Bool
areConcatPrime [] = True
areConcatPrime (x:xs) =
    -- (areConcatPrime xs) && (and $ map concatPrime_x xs)
    all concatPrime_x xs
    where 
        concatPrime_x :: Int -> Bool
        concatPrime_x y = all is_prime [concatNumbers x y, concatNumbers y x]


-- for 1 should return a list of one element list containing a unique prime
--
cprimes :: Int -> [[Int]]
cprimes n = concatMap (memoizedConcatPrimes n) [(n-1)..]

-- concatPrimes' :: Int -> Int -> [[Int]]
-- concatPrimes' 0 _ = [[]]
-- concatPrimes' _ (-1) = error "concatPrimes' ERROR"
-- concatPrimes' _ 0 = []
-- concatPrimes' 1 max = [[ primes !! fromInt max ]]
-- concatPrimes' n max = filter areConcatPrime [ p:cprimes | cprimes <- subsets  ]
--     where p = primes !! fromInt max
--           -- subsets = memoized !! fromInt (n-1)
--           subsets = concatMap (concatPrimes' (n-1)) [0..(max-1)]

memoizedConcatPrimes n max =
    let p =  primes !! max
        subsets = concatMap (memoizedConcatPrimes (n-1)) [0..(max-1)]
        concatPrimes 0 _ = [[]]
        concatPrimes _ 0 = []
        concatPrimes 1 max = [[ primes !! max ]]
        concatPrimes n max = filter areConcatPrime [p:cprimes | cprimes <- subsets ]
    in  map (map concatPrimes [0..] !! n) [0..] !! max

main = do
    print $ take 20 $ cprimes 2
    print $ cprimes 3 !! 0
    print $ cprimes 3 !! 1
    print $ cprimes 3 !! 2
    print $ take 20 $ cprimes 3
    print $ cprimes 4 !! 0
    print $ cprimes 4 !! 1
    print $ cprimes 4 !! 2
    let res = take 3 $ cprimes 5
    print res
    print (map sum res)
