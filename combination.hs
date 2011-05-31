-- n=5 max=5 -> 12345
-- n=5 max=6 -> 12346, 12356, 12456, 13456, 23456
-- n=5 max=7 -> 12347, 12357, 12367, 12457, 12467...

-- n=1 max=1 -> 1
-- n=1 max=2 -> 2
-- n=1 max=3 -> 3
--
-- n=2 max=2 -> 12
-- n=2 max=3 -> 13, 23
-- n=2 max=4 -> 14, 24, 34
-- n=2 max=5 -> 15, 26, 35, 45
--
-- n=3 max=3 -> 123
-- n=3 max=4 -> 124, 134, 234
-- n=3 max=5 -> 125, 135, 235, 145, 245, 345  (n=2,max=2 ; n=2,max=3 ; n=2,max=4)++[5]
combination :: (Ord a) => Int -> a -> [a] -> [[a]]
combination 0 max list = []
combination n max (x:xs@(y:ys)) 
    | x>max             = []
    | n==1 && 
      x<=max && y>max   = [[x]]
    | otherwise         = ( map (\z -> x:z)  $ combination (n-1) max xs )
                            ++ combination n max xs

all_combinations n xs = foldr (++) [] $ map (\i -> combination n (xs!!i) xs) [(n-1)..]

main = do
        putStrLn $ show $ combination 5 5 [1..]
        mapM_ putStrLn (map show $ take 50 $ all_combinations 5 [1,3..])
