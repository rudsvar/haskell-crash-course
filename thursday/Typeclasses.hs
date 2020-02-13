-- % Typeclasses

module Typeclasses where

-- Describe some behavior, but not implementation.
-- Is very similar to interfaces.
-- Examples: Show, Eq, Ord
--
-- Show examples:
-- - `show 123`
-- - `show "abc"`
-- - `show id`

data Expr = Var String | Add Expr Expr | Mul Expr Expr
  -- deriving show

instance Show Expr where
  show (Var v    ) = v
  show (Add e1 e2) = show e1 ++ " + " ++ show e2
  show (Mul e1 e2) = show e1 ++ " * " ++ show e2

data List = List [Int] Int
  -- deriving Show

instance Show List where
  show (List xs len) =
    "List with length " ++ show len ++ " and elements " ++ show xs

-- Creating our own typeclasses

class Addable a where
  add :: a -> a -> a

instance Addable Int where
  add i1 i2 = i1 + i2

instance Addable [a] where
  add s1 s2 = s1 ++ s2

instance Addable List where
  add (List xs len1) (List ys len2) = List (xs ++ ys) (len1 + len2)

-- Commonly, Haskell does not use the -able ending
-- If we want a more complicated typeclass:

data Pos = Pos Int Int

instance Num Pos where
  Pos x1 y1 + Pos x2 y2 = Pos (x1 + x2) (y1 + y2)
  signum (Pos x y) = Pos (signum x) (signum y)
  abs (Pos x y) = Pos (abs x) (abs y)
  negate (Pos x y) = Pos (negate x) (negate y)
  fromInteger i = Pos (fromInteger i) (fromInteger i)
  Pos x1 y1 * Pos x2 y2 = Pos (x1 * x2) (y1 * y2)

instance Num Bool where
  b1 + b2 = b1 || b2
  b1 * b2 = b1 && b2
  abs    = id
  negate = not
  signum = id
  fromInteger i = i > 0

class Creature a where
  getName :: a -> String
  getAge :: a -> Int
  isFriendly :: a -> Bool

data Person = P String Int

instance Creature Person where
  getName (P name _) = name
  getAge (P _ age) = age
  isFriendly _ = False

data Dog = D String Int String

instance Creature Dog where
  getName (D name _ _) = name
  getAge (D _ age _) = age
  isFriendly _ = True
