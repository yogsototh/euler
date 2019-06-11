-- What is most surprising is that the important mathematical constant,
-- e = [2; 1,2,1, 1,4,1, 1,6,1 , ... , 1,2k,1, ...].
-- 
-- The first ten terms in the sequence of convergents for e are:
-- 2, 3, 8/3, 11/4, 19/7, 87/32, 106/39, 193/71, 1264/465, 1457/536, ...
-- 
-- The sum of digits in the numerator of the 10th convergent is 1+4+5+7=17.
-- 
-- Find the sum of digits in the numerator of the 100th convergent of the continued fraction for e.


s = 2:rest 1
    where rest k = 1:2*k:1:rest (k+1)

calc (x:[]) = (x,1)
calc (x:xs) = let 
                precalc = calc xs
                num = fst precalc
                den = snd precalc
              in
                (x * num + den, num)
    
sumText :: Integer -> Integer
sumText bignum = sum $ map (\x -> read (x:[]) :: Integer) $ show bignum

main = do
    -- print $ sumText $ fst $ calc $ take 10 s
    print $ sumText $ fst $ calc $ take 100 s
