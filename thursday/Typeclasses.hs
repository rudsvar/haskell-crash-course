-- % Typeclasses

module Typeclasses where

-- Describe some behavior, but not implementation.
-- Is very similar to interfaces.
-- Examples: Show, Eq, Ord

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
