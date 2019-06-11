module Prime
( primes
, is_prime
, primeFactors
, relativePrime
)
where 
    import Data.List

    data Wheel = Wheel Int [Int]
    roll (Wheel n rs) =  [n*k+r| k<-[0..], r<-rs]
    
    nextSize (Wheel n rs) p =
        Wheel (p*n) [r' | k <- [0..(p-1)], r <- rs,
                        let r' = n*k+r, r' `mod` p /= 0]
    w0 = Wheel 1 [1]
    
    mkWheel ds = foldl nextSize w0 ds
    
    primes :: [Int]
    primes = small ++ large
        where
            1:p:candidates  = roll $ mkWheel small
            small           = [2,3,5,7]
            large           = p : filter isPrime candidates
            isPrime n       = all (not . divides n)
                                $ takeWhile (\p -> p*p <= n) large
            divides n p     = n `mod` p == 0
    
    is_prime n = n > 1 && n == head (primeFactors n)
    primeFactors 1 = []
    primeFactors n = go n primes
        where
            go n ps@(p:pt)
                | p*p > n           = [n]
                | n `rem` p == 0    = p : go (n `quot` p) ps
                | otherwise         = go n pt

    relativePrime :: Int -> Int -> Bool
    relativePrime p q = [] == intersect (primeFactors p) (primeFactors q)
