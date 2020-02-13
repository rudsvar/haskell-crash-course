{- Partial application and currying -}
-- You can read more at http://learnyouahaskell.com/higher-order-functions#curried-functions

-- We have shown several examples of Haskell functions which seemingly take more than one argument, such as

add :: Int -> Int -> Int
add x y = x + y

-- However, this is not entirely accurate. Every Haskell function takes one parameter only.
-- So how does that work?
-- All functions which have seemingly accepted multiple parameters have been "curried functions".
-- Probably easier to understand by showing an example.

-- add 2 3 looks like it takes two integers as input and returns their sum, 5.
-- However, what actually happens is that add takes one integer 2,
-- and returns a function "add 2" waiting for another integer.

-- Try :t add, :t add 2, :t (add 2) 3
-- add 2 3 is equal to (add 2) 3!

-- Thus, add :: Int -> Int -> Int is equal to
--       add :: Int -> (Int -> Int)
--              2       add 2 x

-- i.e. add takes an integer and returns a function which takes an integer and returns an integer.

-- A function called with too few parameters is called a "partially applied function."
-- A partially applied function takes as many parameters as we left out when calling the original function.

-- More examples
multThree :: Int -> Int -> Int -> Int
multThree x y z = x * y * z

-- multThree 2 3 4 is equal to ((multThree 2) 3) 4
-- Try :t multThree, :t (multThree 2) 3, :t ((multThree 2) 3) 4

-- They can be useful when passing functions as parameters to other functions.
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
dropSmallerThanThree :: [Int] -> [Int]
dropSmallerThanThree xs = filter lessThanThree xs
-- dropSmallerThanThree xs = filter (\x -> x < 3) xs
-- dropSmallerThanThree xs = filter (< 3) xs

lessThanThree :: Int -> Bool
lessThanThree x = x < 3
-- lessThanThree = \x -> x < 3
-- lessThanThree = < 3

-- lessThanThree, \x -> x < 3 and (< 3) all take one numerical argument and return a bool.

-- Let's try a slightly more complicated lambda.




-- filter is a higher-order function, which is a function that either takes a function as an argument, returns a function, or both.
-- We will talk more about higher-order functions later.

