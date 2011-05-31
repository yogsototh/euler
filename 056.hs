to_list x = [x]

char_to_int c = read $ to_list c :: Integer

digital_sum :: Integer -> Integer
digital_sum n = sum $ map ( char_to_int ) ( show n )

find_max n m = foldr max 0 [ digital_sum (a^b) | a <- [1..n], b <- [1..m]]

main = do
        putStrLn $ show $ find_max 100 100
