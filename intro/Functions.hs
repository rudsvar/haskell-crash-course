{- Intro to functions in Haskell -}

import Data.Char (toUpper)

-- This function takes one Int as input,
-- and returns that same value as output.
identity :: Int -> Int
identity x = x

-- When defining functions, the function names need to be aligned.
-- This is not allowed:
-- f :: Int -> Int
--   f x = x + 2

-- Adding two integers in Java:
-- public int add(int x, int y) {
--     return x+y;
-- }

-- This function takes two integers as input, and returns the sum of the two.
add :: Int -> Int -> Int
add x y = x + y

-- This function takes one argument only - a tuple.
mul :: (Int, Int) -> Int
mul (x,y) = x * y

-- add and mul do not have the same type signatures!

-- Haskell is purely functional, i.e. in general, everything evaluates to a value.
-- All values are immutable, meaning we cannot change existing values.
-- Thus, Haskell does not allow traditional for or while loops,
-- since we cannot update loop variables.
-- Instead of using loops, we can use recursion.




reverseString :: String -> String
reverseString []       = []
reverseString (x : xs) = reverseString xs ++ [x]

-- This function checks whether a given string is a palindrome.
isPalindrome :: String -> Bool
isPalindrome s = s == reverseString s

stringToUpper :: String -> String
stringToUpper []        = []
stringToUpper (c : str) = toUpper c : stringToUpper str

-- We can also pass functions as arguments!
filterBy :: (Int -> Bool) -> [Int] -> [Int]
filterBy _ [] = []
filterBy pred (x:xs)
  = if pred x then x : filterBy pred xs
              else filterBy pred xs
