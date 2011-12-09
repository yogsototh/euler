-- Problem 63
-- 13 February 2004
--
-- The 5-digit number, 16807=7^5, is also a fifth power. Similarly, the 9-digit number, 134217728=8^9, is a ninth power.
--
-- How many n-digit positive integers exist which are also an nth power?

powers n = map (^n) [1..100]

is_solution n x = (x >= 10^(n-1)) && (x < 10^n)

find n = filter (is_solution n) (powers n)

main = do
    print $ sum $  map (length . find) [1..100]
