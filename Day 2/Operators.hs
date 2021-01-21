-- % Operators

module Operators where

----------------------
-- INFIX AND PREFIX --
----------------------

-- Most functions are prefix by default, i.e. you write the function name before the arguments
-- foo x y = ...

-- Operators are just functions that are infix by default

-- You can use prefix instead of infix using ():

{-
   (+) 2 3 == 5
   (*) 2 3 == 6
-}

-- Note that you must also use () around operators when you check the type with :t (e.g. :t (+))

-- From prefix to infix with `` (these are backtics, not single quotes!)

add :: Int -> Int -> Int
add x y = x + y      -- Prefix syntax
-- x `add` y = x + y -- Infix syntax

-- Examples:
-- add 1 4 == 5
-- 2 `add` 4 == 6

-------------------
-- INT VS. FLOAT --
-------------------

-- Question: What type is the value 2? What type is the expression 2 + 3?

-- It is not uncommon to assume that this 2 is an integer, and that 2 + 3 evaluates to an integer.
-- However, this is inaccurate. Try :t 2, :t 2 + 3
-- All the compiler knows here is that 2 and 3 are numerical values - not necessarily that they are integers!

-- Example: 2 + 2.5 is valid expression.
-- It may look like we are adding an integer and a fractional, though this is not accurate either.
-- 2.5 is fractional, so 2 is also assumed to be fractional (i.e. 2.0)
-- The reason for this conversion is that (+) expects two arguments of the same type.
-- See :t (+)

-- There are many numeric types in Haskell, and it may always be obvious what types are being used in all cases.
-- Some numeric types are denoted as Integral, i.e. some kind of integer value (e.g. Int, Integer)
-- Some numeric types are denoted as Fractional, i.e. some kind of floating point number (e.g. Double, Float)
-- Num, Integral and Fractional are examples of type classes - this will be explained later on in the course.
-- For now, just know that Num, Integral and Fractional refer to some set of numeric Haskell types.

-- The usual operators (+, *, -) can be used with both integer and fractional values.
-- Other operators and numeric functions are less permissive (such as / - fractional division).
-- Example: 1 / 2 is valid, and evaluates to 0.5.
-- Example: (1 :: Int) / (2 :: Int) is not valid!

-- Consider the type signature of the function below: Is it valid? Why or why not?

-- myAdd :: Int -> Int -> Float
myAdd x y = x + y

-- Try :t (+), :t (*), :t (/), :t mod

-- Conversion between them can be done with fromInteger, floor, ceiling, round

-- TODO: Show conversion between Int and Float

------------------------
-- DEFINING OPERATORS --
------------------------

-- You can define new operators.
-- You must use parentheses around the operator in the type signature.

(%) :: Int -> Int -> Int
-- (%) x y = mod x y
(%) x y = x `mod` y

-- Somewhere:
-- Function application has higher precedence than any infix operator.
-- Example: floor 1.5 + ceiling 1.5 is reduced to (floor 1.5) + (ceiling 1.5) = 1 + 2 = 3.