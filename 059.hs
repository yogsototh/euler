import System

main = do
    [filename] <- readArgs
    f <- open(
