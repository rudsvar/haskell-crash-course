-- % Operators and Fixity

module Operators where

-- Operators are just functions that are infix by default

(*) :: Int -> Int -> Int
(*) x y = x + y

-- You can define new operators

(%) :: Int -> Int -> Int
(%) x y = mod x y
(%) x y = x `mod` y

-- From infix to prefix with ()

{-
   (+) 2 3 == 5
   (*) 2 3 == 6
-}

-- From prefix to infix with ``

-- > add x y = x + y
-- > 2 `add` 3
-- 5

-- Fixity

-- When using infix notation, we have a slight problem: precedence.

-- > 2 + (3 * 4)
-- 14
-- > (2 + 3) * 4
-- 20

-- > :info (+)
-- ...
-- infixl 6 +
--
-- > :info (*)
-- ...
-- infixl 7 *
