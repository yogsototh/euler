-- Source forum project haskell
import Data.Bits
import Data.Char
import Data.List

keys = [ [a,b,c] | a <- [97..122], b <- [97..122], c <- [97..122] ]
allAlpha a = all (\k -> let a = ord k in ( a >= 32 && a <= 122)) a
howManySpaces x = length (elemIndices ' ' x)
compareBy f x y = compare (f x) (f y)

main = do
    s <- readFile "cipher1.txt"
    let
        cipher = (read ("[" ++ s ++ "]") :: [Int])
        decrypts = [ (map chr (zipWith xor (cycle key) cipher), map chr key) | key <- keys ]
        alphaDecrypts = filter (\(x,y) -> allAlpha x) decrypts
        message = maximumBy (\(x,y) (x',y') -> compareBy howManySpaces x x') alphaDecrypts
        asciisum = sum (map ord (fst message))
    putStrLn ("The message " ++ (fst message) ++ " was encoded with key " ++ (snd message))
    putStrLn (show asciisum)
