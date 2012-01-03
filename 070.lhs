Euler's Totient function, φ(n) [sometimes called the phi function], is used to determine the number of positive numbers less than or equal to n which are relatively prime to n. For example, as 1, 2, 4, 5, 7, and 8, are all less than nine and relatively prime to nine, φ(9)=6.
The number 1 is considered to be relatively prime to every positive number, so φ(1)=1.

Interestingly, φ(87109)=79180, and it can be seen that 87109 is a permutation of 79180.

Find the value of n, 1 < n < 107, for which φ(n) is a permutation of n and the ratio n/φ(n) produces a minimum.


---

From problem 069 we have a fast way to compute the function phi.

> import Data.List
> import Prime

> phi :: Int -> Int
> phi n = let decomp = map head $ group $ primeFactors n
>         in foldl' (\acc p-> (acc `div` p) * (p-1)) n decomp

We also define nphi which is just n/phi(n)

> nphi :: Int -> Float
> nphi n = (fromIntegral n) / fromIntegral (phi n)

We also need a function to verify a number is a permutation of another number.

> arePermutEquiv p q = sort (show p)  == sort (show q)

Now we only have to verify for all n

> interrestingNumbers n = concatMap foo [2..n]
>                       where
>                           foo x = if arePermutEquiv x (phi x)
>                                   then [(x,nphi x)]
>                                   else []

The function to return the result:

> takeMaximal :: [(Int,Float)] -> (Int,Float) -> (Int,Float)
> takeMaximal [] (best,minratio) = (best,minratio)
> takeMaximal ((n,ratio):xs) (best,minratio) =
>     if ratio<minratio then takeMaximal xs (n,ratio) else takeMaximal xs (best,minratio)

> main = do
>       print $ takeMaximal ( interrestingNumbers (10^7) ) (0,10^7)
