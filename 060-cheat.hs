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

solve = do
    a <- primesTo10000
    let m = f a $ dropWhile (<= a) primesTo10000
    b <- m
    let n = f b $ dropWhile (<= b) m
    c <- n
    let o = f c $ dropWhile (<= c) n
    d <- o
    let p = f d $ dropWhile (<= d) o
    e <- p
    return [a,b,c,d,e]
    where
        f x = filter (\y -> all is_prime  [concatNumbers x y, concatNumbers y x])
        primesTo10000 = takeWhile (<= 10000) primes


main = do
    print $ head $ solve
    print $ sum $ head $ solve
