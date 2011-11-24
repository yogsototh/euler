import Data.List
type YInt = Int

collatz :: YInt -> YInt
collatz n
    | n < 0 = 1
    | even n = n `quot` 2
    | otherwise = 3 * n + 1

-- The l `seq` is necessary to not be lazy (non-strict)
-- And not to fill the stack
lencollatz' :: YInt -> YInt -> YInt
lencollatz' l 1 = l
lencollatz' l n = l `seq` lencollatz' (l + 1) (collatz n)

lencollatz = lencollatz' 0

-- The j `seq` is necessary to not be lazy (non-strict)
-- And not to fill the stack
maximalIndex :: (YInt, YInt) -> YInt -> [YInt] -> (YInt, YInt)
maximalIndex (m, i) j [] = (m, i)
maximalIndex (m, i) j (x : xs) = j `seq` maximalIndex res (j + 1) xs
                              where res = if x > m then (x, j) else (m, i)

showCollatz :: YInt -> String
showCollatz 1 = "1"
showCollatz n = show n ++ " → " ++ showCollatz ( collatz n )

pure (Just x) = x

main = do
            putStrLn $ "max len: " ++ show m
            putStrLn $ "max value: " ++ show i
            -- print mrec
            -- print irec
            -- putStrLn $ showCollatz $ toInteger i
       where
            array = map lencollatz [1 .. 1000000]
            m = maximum array
            i = 1 + pure (elemIndex m array)
            (mrec, irec) = maximalIndex (0, 0) 1 array
