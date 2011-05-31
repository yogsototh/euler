-- It is possible to show that the square root of two 
-- can be expressed as an infinite continued fraction.
--
-- √ 2 = 1 + 1/(2 + 1/(2 + 1/(2 + ... ))) = 1.414213...
--
-- By expanding this for the first four iterations, we get:
--
-- 1 + 1/2 = 3/2 = 1.5
-- 1 + 1/(2 + 1/2) = 7/5 = 1.4
-- 1 + 1/(2 + 1/(2 + 1/2)) = 17/12 = 1.41666...
-- 1 + 1/(2 + 1/(2 + 1/(2 + 1/2))) = 41/29 = 1.41379...
--
-- The next three expansions are 99/70, 239/169, and 577/408, 
-- but the eighth expansion, 1393/985, 
-- is the first example where the number of digits in the numerator exceeds 
-- the number of digits in the denominator.
--
-- In the first one-thousand expansions, 
-- how many fractions contain a numerator with more digits than denominator?
--

-- Thoughts :
-- 1 + 1/2  = 3/2
-- 1 + 1/(2 + 1/2) = 1 + 1/(5/2)
--                 = 1 + 2/5
--                 = 5 + 2 / 5
--                 = 7/5
-- F_n = p/q
-- F_{n+1}
--
-- 1 + 1/( 1 + p/q ) = 1 + 1/( q+p / q)
--                   = 1 + q / q+p
--                   = 2q+p / q+p
--

next (p,q) = (2*q + p , p+q)

nb_digits n = length $ show n

digits 0 x = []
digits n x = y:(digits (n-1) y)
             where y = next x

greater_numerator (p,q) = (nb_digits p) > (nb_digits q)

nb_greater_numerator n = length $ filter (greater_numerator) (digits n (1,1))

main = do
        putStrLn $ show $ nb_greater_numerator 1000
