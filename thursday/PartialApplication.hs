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
multThree :: Int -> Int -> Int
multThree x y z = x * y * z

-- multThree 2 3 4 is equal to ((multThree 2) 3) 4
-- Try :t multThree, :t (multThree 2) 3, :t ((multThree 2) 3) 4

-- They can be useful when passing functions as parameters to other functions.
-- We'll talk more about this later we go through higher order functions.

{- Lambdas -}

-- Also known as anonymous functions
-- Can be used if you want to create a function which is used once, and has a short function body
-- Often used in tandem with higher order functions, which we will discuss later

