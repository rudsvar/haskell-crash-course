module CustomTypes where

-- # Type aliases (1 min)

-- Lets you define an alternative name for a type.
-- Useful for making typing complex types easier (e.g. [([Foo], [Bar])]),
-- as well as giving a hint to what it is used for (e.g. PhoneNumber).

type MyString = [Char]

type PhoneNumber = String

-- # Defining new data types (10 min)

-- Wrap another type (usually `newtype` is used here, but that is not important).
-- If there is only one constructor, its name is often the same as the type (IntWrapper).
-- See type of `WrapInt`.
data IntWrapper = WrapInt Int deriving (Show)

-- Unwrap the value by pattern matching on it, perform an operation on it, then re-wrap it.
inc :: IntWrapper -> IntWrapper
inc (WrapInt i) = WrapInt (i + 1)

-- Store more data in a single type.
-- The two `Int`s are like fields (but are not named).
-- This means that we can only extract them with pattern matching.
-- See type of `MkTuple`.
data Tuple = MkTuple Int Int deriving (Show)

-- Task 1: Swap the two fields in the tuple.
swap :: Tuple -> Tuple
swap (MkTuple x y) = MkTuple y x

-- Type aliases to make field meaning more obvious.
-- Without it, we would just have a `Float`.
type Radius = Float

-- Wrapper types to get compile time errors if we get the order wrong.
-- Drawback: More unwrapping whenever we want to use it.
data Height = Height Float deriving (Show)

data Width = Width Float deriving (Show)

-- We can have multiple constructors, each with different fields.
-- Note that these fields are not named, so we can only access values with
-- pattern matching. Will come back to how we can name them later.
-- See type of `Circle` and `Rectangle`.
data Shape = Circle Radius | Rectangle Height Width deriving (Show)

-- Create a string that describes the shape.
-- We must now match on `Height` and `Width` too.
area :: Shape -> Float
area (Circle radius) = pi * radius ^ 2
area (Rectangle (Height height) (Width width)) = height * width

-- # Types from Prelude and polymorphism (10 min)

-- Defining our own `Bool`.
data MyBool = MyFalse | MyTrue
  deriving (Show)

-- Represent missing result.
-- Avoid things like `NullPointerException` by forcing the programmer to handle it.
-- Similar to `Option<T>` in Java.
data MyMaybe a -- type parameter
  = MyNothing
  | MyJust a
  deriving (Show)

-- Square root only works for non-negative numbers.
-- How do we signal an error?
maybeSquareRoot :: Float -> MyMaybe Float
maybeSquareRoot x = if x < 0 then MyNothing else MyJust (sqrt x)

-- Alternative implementation with guards.
-- Guards can be much better with many branches.
maybeSquareRoot' :: Float -> MyMaybe Float
maybeSquareRoot' x
  | x < 0 = MyNothing
  | otherwise = MyJust (sqrt x)

-- What if we want to include more information about what went wrong?
-- data Either a b = Left a | Right b in Prelude.
data Result a b = Err a | Ok b deriving (Show)

-- Task 2: squareRoot with a more detailed error message.
resultSquareRoot :: Float -> Result String Float
resultSquareRoot x
  | x < 0 = Err "Number must be non-negative!"
  | otherwise = Ok (sqrt x)

-- # Representing arithmetic expressions and evaluating them (10 min)

-- Let's try to represent a simple language with a new type.
-- We want to be able to add, multiply and negate numbers,
-- so let's make cases for each of those.
data IntExpr
  = Number Int
  | Add IntExpr IntExpr
  | Mul IntExpr IntExpr
  | Negate IntExpr
  deriving (Show)

-- Task 3 (partially): Evaluate the arithmetic expression
evalIntExpr :: IntExpr -> Int
evalIntExpr (Number i) = i
evalIntExpr (Add e1 e2) = evalIntExpr e1 + evalIntExpr e2
evalIntExpr (Mul e1 e2) = evalIntExpr e1 * evalIntExpr e2
evalIntExpr (Negate e) = - evalIntExpr e -- could use `negate`

-- # BTL (Basic Types and Programming Languages Language)

-- You will come across this language later in the course.
-- This is a short introduction to it (3 min), and how one can be evaluated (12 min).

-- We have a strange representation of numbers, where we have a constant (0), and
-- bigger numbers are built up as expressions using `Succ` and `Pred`.
-- So Zero = 0, Succ Zero = 1, Succ (Succ Zero) = 2, and so on.

-- We also want to be able to check if a number is zero, so we add a constructor `IsZero`.

-- Evaluating `IsZero` of some expression should give us a boolean, so we need `ETrue` and `EFalse`.
-- This result can then be used as a predicate for the `If` case, which gives us a new expression depending
-- on the value of the predicate.

-- Expression
data BTLExpr
  = Zero -- Constant `0`
  | Succ BTLExpr -- Successor of a number (+1)
  | Pred BTLExpr -- Predecessor of a number (-1)
  | IsZero BTLExpr -- Check if an expression evaluates to Zero
  | ETrue -- Constant `True`
  | EFalse -- Constant `False`
  | If BTLExpr BTLExpr BTLExpr -- If-expression
  deriving (Show)

-- An expression can evaluate to a `Bool`, `Int` or give an error.
data Value = VBool Bool | VInt Int | VError String deriving (Show)

-- Evaluate the expression, starting with the most simple
-- base cases, then using recursion to evaluate sub-expressions.
eval :: BTLExpr -> Value
-- Base cases
eval Zero = VInt 0
eval ETrue = VBool True
eval EFalse = VBool False
-- Match with case of
eval (Succ e) = case eval e of
  VInt i -> VInt (i + 1)
  _ -> VError "Can only use Succ on VInt"
-- Match with guards
eval (Pred e)
  | VInt i <- eval e =
    VInt (i - 1)
  | otherwise = VError "Can only use Pred on VInt"
-- Boolean logic
eval (IsZero e) = case eval e of
  VInt 0 -> VBool True
  VInt _ -> VBool False
  _ -> VError "Can only use IsZero on Int"
-- Evaluate predicate, then decide branch
eval (If predicate branch1 branch2) = case eval predicate of
  VBool True -> eval branch1
  VBool False -> eval branch2
  _ -> VError "Predicate must be Bool"

-- # Bonus: Record type (5 min)

-- Single constructor, multiple named fields.
-- Functions for extracting fields are automatically generated.
data Person = MkPerson
  { name :: String, -- name :: Person -> String
    age :: Int -- age :: Person -> Int
  }
  deriving (Show)

-- Use the generated functions to access fields
printPerson :: Person -> String
printPerson person = name person ++ " is " ++ show (age person) ++ " years old"