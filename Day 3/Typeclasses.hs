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

-- data Pos = Pos Int Int

-- instance Num Pos where
--   Pos x1 y1 + Pos x2 y2 = Pos (x1 + x2) (y1 + y2)
--   signum (Pos x y) = Pos (signum x) (signum y)
--   abs (Pos x y) = Pos (abs x) (abs y)
--   negate (Pos x y) = Pos (negate x) (negate y)
--   fromInteger i = Pos (fromInteger i) (fromInteger i)
--   Pos x1 y1 * Pos x2 y2 = Pos (x1 * x2) (y1 * y2)

-- instance Num Bool where
--   b1 + b2 = b1 || b2
--   b1 * b2 = b1 && b2
--   abs    = id
--   negate = not
--   signum = id
--   fromInteger i = i > 0

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

-- Queue (Advanced)

-- Define a typeclass ("interface") that specifies 4 operations.
-- q here is parameterized by a type `a`. For instance, if q is `[]` (the list
-- type), and `a` is Int. Then the type of `push` is:
-- push :: Int -> [Int] -> [Int]
-- i.e. it takes an Int to be pushed, then the queue, and then returns the
-- new queue you get by adding the new element.
class Queue q where
  push :: a -> q a -> q a -- Adds a new element to the queue.
  pop :: q a -> (a, q a) -- Returns the last element in the queue, and the new queue with the element removed from it.
  isEmpty :: q a -> Bool -- Lets us check if the queue is empty, to avoid popping from an empty queue.
  isFull :: q a -> Bool -- Lets us check if the queue is full, to avoid pushing to a full queue.

-- Let's implement the Queue typeclass for the List type
instance Queue [] where
  -- push :: a -> [a] -> [a]
  push value list = value : list
  -- We want to remove the last element in the list, so we need to do a bit
  -- of reversing here (reverse it, then remove what is now the front element,
  -- then reverse the remaining list again to get it back to original order.)
  -- pop :: [a] -> (a, [a])
  pop [] = error "Trying to pop from empty list"
  pop list = let (x:xs) = reverse list in (x, reverse xs)
  -- e.g. pop [1,2,3] returns (3, [1,2]), where 3 is the popped element.
  -- We don't want to remove `1` because that's the element that was last pushed
  -- to the Queue. If we did that, then this would be a stack, not a queue.
  isEmpty [] = True
  isEmpty _ = False

  isFull _ = False -- The list has "infinite" space. It is never full.

-- Works on any type that implements Queue, not just Lists.
getQueueSize :: Queue q => q a -> Int
getQueueSize queue = if isEmpty queue
                        then 0
                        else 1 + getQueueSize queueAfterPop
                          where (poppedElement, queueAfterPop) = pop queue

-- Let's write a silly Queue implementation for Maybe (Can hold at most 1 element)
instance Queue Maybe where
  -- push :: a -> Maybe a -> Maybe a
  push value Nothing = Just value
  push value (Just oldValue) = error "Trying to push to full MaybeQueue"

  -- pop :: Maybe a -> (a, Maybe a)
  pop Nothing = error "Trying to pop from empty MaybeQueue"
  pop (Just v) = (v, Nothing) -- Pop v, new queue is now empty

  isEmpty Nothing = True
  isEmpty _ = False

  isFull Nothing = False
  isFull _ = True

-- Functor from prelude

-- A functor is any type that supports the mapping operation.
-- Usually, they are "containers" that contain some value, and let you transform
-- all their values with a given function.
-- This class does the same as `Functor`, except the functor there is called `fmap`.
class MyFunctor f where
  myFmap :: (a -> b) -> f a -> f b

-- One example is a List. For instance, if you have a List of Ints ([Int]),
-- and a function (Int -> a), then you can transform the list to [a] by mapping
-- the function over the list.
myNumbers :: [Int]
myNumbers = [1, 2, 3]

myNegatedNumbers :: [Int] -- negate :: Int -> Int, so our new list is also [Int]
myNegatedNumbers = fmap negate myNumbers -- [-1, -2, -3]

myNumbersAsStrings :: [String] -- show :: Int -> String
myNumbersAsStrings = fmap show myNumbers -- ["1", "2", "3"]

instance MyFunctor [] where
  myFmap f [] = []
  myFmap f (x:xs) = f x : myFmap f xs

-- Another "container" type where it makes sense to map over functions is the
-- `Maybe` type, which essentially behaves the same as a list that contains 0
-- or 1 elements.
instance MyFunctor Maybe where
  myFmap f Nothing = Nothing
  myFmap f (Just x) = Just (f x)

-- As more confusing example -- we can map over IO as well:
instance MyFunctor IO where
  myFmap f action = do
    result <- action -- Extract the value
    return (f result) -- Apply f to the extracted value, then wrap it inside IO again.

-- getLine :: IO String
-- length :: String -> Int
-- `fmap length getLine` changes the "contained" type of getLine from String to Int.
getLineAndReturnLength :: IO Int
getLineAndReturnLength = fmap length getLine

-- same as
getLineAndReturnLength' = do
  line <- getLine
  return (length line)
