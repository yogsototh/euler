-- num_reverse :: Num a -> Num a
num_reverse = read . reverse . show 

-- num_palindrom :: Num a -> Bool
num_palindrom n = (show n) == (reverse $ show n)

-- lychrel :: Num a -> Num a -> Bool
lychrel     0 n = False
lychrel depth n = ( num_palindrom number ) || lychrel (depth - 1) number 
                  where number = n + (num_reverse n)

-- nblychrel :: Num a -> Num a
nblychrel n = length $ filter (not . lychrel 50) [1..n]

main = do
    putStrLn $ show ( lychrel 50 196 )
    putStrLn $ show ( nblychrel n )
    where n = 10000
