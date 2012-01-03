Euler's Totient function, 
φ(n) [sometimes called the phi function], 
is used to determine the number of numbers less than n which are 
relatively prime to n. 
For example, as 1, 2, 4, 5, 7, and 8, 
are all less than nine and relatively prime to nine, φ(9)=6.

    n   Relatively Prime    φ(n)    n/φ(n)
    2   1                   1       2
    3   1,2                 2       1.5
    4   1,3                 2       2
    5   1,2,3,4             4       1.25
    6   1,5                 2       3
    7   1,2,3,4,5,6         6       1.1666...
    8   1,3,5,7             4       2
    9   1,2,4,5,7,8         6       1.5
    10  1,3,7,9             4       2.5

It can be seen that n=6 produces a maximum n/φ(n) for n ≤ 10.

Find the value of n ≤ 1,000,000 for which n/φ(n) is a maximum.

---

Let's begin the code.
First we import the function done for other problems

> import Prime (relativePrime,primeFactors)
> import Data.List (foldl',elemIndex,intersect,group)
> import Data.Maybe

We define the function phi

> pf = map primeFactors [2..]

A fast intersection which takes advantage of the fact we know both
lists are growing.

> fastinter _ [] = False
> fastinter [] _ = False
> fastinter (x:xs) (y:ys) 
>   | x == y  = True
>   | x < y   = fastinter xs (y:ys)
>   | x > y   = fastinter (x:xs) ys

A relative prime function which should take advantage of memoized 
prime factors.

> relprime p q = x `seq` y `seq` not $ fastinter x y
>               where 
>                   x = pf !! (p-2)
>                   y = pf !! (q-2)

The phi function. Helped by [wikipedia](http://en.wikipedia.org/wiki/Euler's_totient_function#Computing_Euler.27s_function).
The secret is phi si multiplicative (phi(m.n)=phi(m).phi(n) if gcd(m,n)=1).

> phi :: Int -> Int
> phi n = let decomp = map head $ group $ primeFactors n
>         in foldl' (\acc p-> (acc `div` p) * (p-1)) n decomp

We also define nphi which is just n/phi(n)

> nphi :: Int -> Float
> nphi n = (fromIntegral n) / fromIntegral (phi n)

Then let's do the program:

> main = do
>       print m
>       print $ i+k
>       where
>           k = 2
>           nphilist = map nphi [k..1000000]
>           m = maximum nphilist
>           i = fromJust $ elemIndex m nphilist
