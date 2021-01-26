{- Partial application and currying -}
-- You can read more at http://learnyouahaskell.com/higher-order-functions#curried-functions

-- We have shown several examples of Haskell functions which seemingly take more than one argument at the same time, such as

-- add :: Int -> Int -> Int
add :: Int -> (Int -> Int)
add x y = x + y

-- However, this is not entirely accurate. Every Haskell function takes one argument only.
-- So how does that work?
-- All functions which have seemingly accepted multiple arguments have been "curried functions".
-- Curried functions are functions which take multiple arguments one by one.
-- Probably easier to understand by looking at a few examples.

-- add 2 3 looks like it takes two integers as input and returns their sum, 5.
-- However, what actually happens is that add takes one integer 2,
-- and returns a function "add 2" waiting for another integer.

-- Try :t add, :t add 2, :t (add 2) 3
-- add 2 3 is equal to (add 2) 3!

-- Thus, add :: Int -> Int -> Int is equal to
--       add :: Int -> (Int -> Int)

-- i.e. add takes an integer and returns a function which takes an integer and returns an integer.

-- A function called with fewer arguments than the type signature suggests is called a "partially applied function."
-- A partially applied function takes as many parameters as we left out when calling the original function.

-- More examples
multThree :: Int -> (Int -> (Int -> Int))
multThree x y z = x * y * z

-- multThree 2 3 4 is equal to ((multThree 2) 3) 4
-- Try :t multThree, :t (multThree 2) 3, :t ((multThree 2) 3) 4

-- They can be useful when passing functions as arguments to other functions.
-- We'll talk more about this later we go through higher order functions.

{- Lambdas -}

-- Also known as anonymous functions
-- Can be used if you want to create a function which is used once, and has a short function body
-- Often used in tandem with higher order functions, which we will discuss later

double :: Int -> Int
-- double x = x + x
double = \x -> x + x

-- The two function definitions above equal.
-- (\x -> x*2) 2 yields 4 as its result.

-- Taking multiple arguments:
mult :: Int -> Int -> Int
-- mult x y = x * y
-- mult = \x -> \y -> x * y
mult = \x y -> x * y

-- Pattern matching on input arguments:
first :: (a,b) -> a
-- first (x,_) = x
first = \(x,_) -> x

-- When to use lambdas?

-- Lambdas are often given as input to other functions,
-- and treated as "nameless"/anonymous functions.

-- Let's create a function that takes a list of integers
-- and filters out all integer smaller than 3.
-- i.e. dropSmallerThanThree [1,2,3,4,5] yields [1,2]

-- We use a function filter :: (a -> Bool) -> [a] -> [a]

-- We can simplify by replacing the named function by a lambda.
-- In this case, we can simplify further by not using a lambda,
-- and instead use a simple partially applied function (< 3).

-- Version 1:
dropSmallerThanThree :: [Int] -> [Int]
dropSmallerThanThree xs = filter lessThanThree xs
  where
      lessThanThree :: Int -> Bool
      lessThanThree x = x < 3

-- Version 2:
-- dropSmallerThanThree xs = filter (\x -> x < 3) xs

-- Version 3:
-- dropSmallerThanThree xs = filter (< 3) xs

-- lessThanThree, \x -> x < 3 and (< 3) all take one numerical argument and return a bool.

-- Let's try a slightly more complicated lambda function.
keepEquals :: [(Int, Int)] -> [(Int, Int)]
keepEquals xs = filter (\(x,y) -> x == y) xs

-- filter is a higher-order function, which is a function that either takes a function as an argument, returns a function, or both.
-- We will talk more about higher-order functions later.

----------------------------
-- EXERCISES --

-- Write a function keepNonZero that using
--  a) the where keyword and a named function
--  b) a lambda function
--  c) partial application.
-- The function takes a list of integers and removes all occurrences of 0.
-- Hint: Use the operator /= to check for inequality.

-- keepNonZero :: [Int] -> [Int]
-- keepNonZero xs = filter nonZero xs
--   where
--     nonZero x = x /= 0

-- keepNonZero :: [Int] -> [Int]
-- keepNonZero xs = filter (\x -> x /= 0) xs

-- keepNonZero :: [Int] -> [Int]
-- keepNonZero xs = filter (/= 0) xs