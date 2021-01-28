{- Higher order functions -}

-- The import statements means that we import all functions from Prelude, except map, any and all.
-- This allows us to define our own functions with these names without overlap.
import Prelude hiding (map, any, all)

-- We have already looked at filter, which is a higher-order function.
-- Higher order functions are functions which either take functions as parameters, return functions as values, or both.
-- Examples: map, filter, any, all
-- We implemented a non-polymorphic version of filter on Monday ("filterBy").

-- As we mentioned on Monday, recursion can achieve the things one might otherwise do using a loop in an imperative language.
-- Let's write a simple recursive function

doubleAll :: [Int] -> [Int]
doubleAll [] = []
doubleAll (x:xs) = x * 2 : doubleAll xs
--doubleAll xs = map (*2) xs

squareAll :: [Int] -> [Int]
squareAll [] = []
squareAll (x:xs) = x^2 : squareAll xs
--squareall xs = map (^2) xs

-- This is not necessary how map is actually implemented,
-- but it does the exact same as the Prelude version.
-- map takes a function, applies that function to every element in a list, and returns the new list.
-- Important: We do not alter the old list, we are making a new one based on the old list.
map :: (a -> b) -> [a] -> [b]
map _ []     = []
map f (x:xs) = f x : map f xs

-- Often, we can use map to iterate over a list instead of defining our own recursive function.
-- Here, we can see that partial application and lambdas can be very useful,
-- since they allow us to do things such as giving a function missing one argument to map,
-- which will retrieve the missing argument from a list.

-- This version of any works for lists, specifically.
-- The Prelude version has a slightly more complicated type,
-- though it also works for lists.
-- This function checks whether any of the elements in a list satisfies some predicate.
any :: (a -> Bool) -> [a] -> Bool
any _ []     = False
any p (x:xs) = p x || any p xs

-- Similar to any
-- Checks whether all elements in a list satisfies a predicate.
all :: (a -> Bool) -> [a] -> Bool
all _ []     = True
all p (x:xs) = p x && all p xs
