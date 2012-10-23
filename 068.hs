-- Consider the following "magic" 3-gon ring, filled with the numbers 1 to 6, and each line adding to nine.
--
-- Working clockwise, and starting from the group of three with the numerically lowest external node (4,3,2 in this example), each solution can be described uniquely. For example, the above solution can be described by the set: 4,3,2; 6,2,1; 5,1,3.
--
-- It is possible to complete the ring with four different totals: 9, 10, 11, and 12. There are eight solutions in total.
--             Total   Solution Set
--             9   4,2,3; 5,3,1; 6,1,2
--             9   4,3,2; 6,2,1; 5,1,3
--             10  2,3,5; 4,5,1; 6,1,3
--             10  2,5,3; 6,3,1; 4,1,5
--             11  1,4,6; 3,6,2; 5,2,4
--             11  1,6,4; 5,4,2; 3,2,6
--             12  1,5,6; 2,6,4; 3,4,5
--             12  1,6,5; 3,5,4; 2,4,6
--
-- By concatenating each group it is possible to form 9-digit strings; the maximum string for a 3-gon ring is 432621513.
--
-- Using the numbers 1 to 10, and depending on arrangements, it is possible to form 16- and 17-digit strings. What is the maximum 16-digit string for a "magic" 5-gon ring?

-- SOLUTION in English
{-

Here is a backtracking solution.
+ You can change the type from list to arrays.
  Things should be clearly faster with arrays.

 -}
import Data.List
import Debug.Trace


-- For testing
-- gonSize = 3
gonSize = 5

data Choice = Choice [Int]

-- For debugging purpose
safeIndex s l i = if (length l<i+1)
                  then trace ("ERROR (" ++ s ++ "): " ++ show l ++ "(" ++ show i ++ ")") l!!i
                  else l!!i

-- A better show
instance Show Choice where
  show (Choice l)= str
    where
      n = length l
      nbLines = if n<2*gonSize then (n-1) `div` 2 else gonSize
      str = concatMap show $ (take 3 l) ++ (concatMap (line l) [2..nbLines])
      line l n=map (safeIndex "show" l) [b+1,b,lastelem]
        where
          b=2*(n-1)
          lastelem=if n == gonSize then 1 else b+2

-- Random Access Storage
class RAS a where
  at :: a -> Int -> Int
  nbChoices :: a -> Int
  remove :: a -> Int -> a
  add :: a -> Int -> a
  loop :: (Int -> b) -> a -> [b]

instance RAS Choice where
  at (Choice l) i = safeIndex "at" l i
  nbChoices (Choice l) = length l
  remove (Choice l) i = Choice $ filter (\x -> x/=i) l
  add (Choice l) e = Choice (l++[e])
  loop f (Choice l) = map f l

-- Return true if the current choices keep to be okay
testPartialGon :: Int -> Choice -> Bool
testPartialGon lineSum c =
  let
    n = nbChoices c
    nbLines = if n<2*gonSize then (n-1) `div` 2 else gonSize
  in
  all (testLine c lineSum) [1..nbLines]

-- test that line
testLine :: Choice -- the current partial number choosen
            -> Int -- the sum to verify
            -> Int -- the line of the n-gon
            -> Bool -- the line of the n-gon = sum
testLine c val n =
  let
    b=max 0 2*(n-1)
    lastelem=if n == gonSize then 1 else b+2
    line=[b,b+1,lastelem]
  in
    (==val) . sum . map (at c) $ line

-- return the results
allTests :: [(Int,Choice)]
allTests = concatMap (\s -> testWith s nothing allNumbers ) [6..3*(n-1)]
  where
    nothing = Choice []
    allNumbers = Choice [n,n-1..1]
    n=2*gonSize

-- Where the lineSum occurs
testWith :: Int               -- Sum to verify
            -> Choice         -- choosen
            -> Choice         -- left choices
            -> [(Int,Choice)] -- successful choices
testWith lineSum c lc =
  if testPartialGon lineSum c
  then if nbChoices lc == 0
       then [(lineSum,c)]
       else concat $ loop newTest lc
  else []
    where
      len = nbChoices c
      -- newTest verify that no external number is superior to the first one.
      newTest x = if len>=3 && (len `rem` 2 == 1) && x<at c 0
                    then []
                    else testWith lineSum (add c x) (remove lc x)

main :: IO ()
main = do
  putStrLn "allTest: "
  mapM_ print $ allTests
