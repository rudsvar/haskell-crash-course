module CustomTypes where

-- # Type aliases (1 min)

type MyString = [Char]

type PhoneNumber = String

-- # Defining new data types (10 min)

-- Wrap another type (usually `newtype` is used here, but that is not important).
-- If there is only one constructor, its name is often the same as the type (IntWrapper).
data IntWrapper = WrapInt Int

-- Unwrap the value, perform an operation on it, then re-wrap it.
inc :: IntWrapper -> IntWrapper
inc (WrapInt i) = WrapInt (i + 1)

-- Store more data in a single type
data Tuple = MkTuple Int Int

-- Task 1: Swap the two fields in the tuple
swap :: Tuple -> Tuple
swap (MkTuple x y) = MkTuple y x

-- Type aliases to make fields more obvious
type Radius = Float

type Height = Float

type Width = Float

-- We can have multiple constructors, each with different fields.
-- Note that these fields are not named, so we can only access values with
-- pattern matching. Will come back to how we can name them later.
data Shape = Circle Radius | Rectangle Height Width

-- Create a string that describes the shape.
area :: Shape -> Float
area (Circle radius) = pi * radius ^ 2
area (Rectangle height width) = height * width

-- # Types from Prelude and polymorphism (10 min)

-- Defining our own `Bool`.
data MyBool = MyFalse | MyTrue

-- Represent missing result.
-- Avoid things like `NullPointerException` by forcing the programmer to handle it.
-- Similar to `Option<T>` in Java.
data MyMaybe a -- type parameter
  = MyNothing
  | MyJust a

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

-- What if we want to include more information?
-- data Either a b = Left a | Right b in Prelude.
data Result a b = Err a | Ok b

-- Task 2: squareRoot with a more detailed error message.
resultSquareRoot :: Float -> Result String Float
resultSquareRoot x
  | x < 0 = Err "Number must be non-negative!"
  | otherwise = Ok (sqrt x)

-- # Representing arithmetic expressions and evaluating them (10 min)

-- A more complex type representing an expression
data IntExpr
  = Value Int
  | Add IntExpr IntExpr
  | Mul IntExpr IntExpr
  | Negate IntExpr

-- Task 3 (partially): Evaluate the arithmetic expression
evalIntExpr :: IntExpr -> Int
evalIntExpr (Value i) = i
evalIntExpr (Add e1 e2) = evalIntExpr e1 + evalIntExpr e2
evalIntExpr (Mul e1 e2) = evalIntExpr e1 * evalIntExpr e2
evalIntExpr (Negate e) = - evalIntExpr e -- could use `negate`

-- # BTL (Basic Types and Programming Languages Language)
-- You will come across this language later in the course.
-- This is a short introduction to it (3 min), and how one can be evaluated (12 min).

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

-- Use the generated functions to access fields
printPerson :: Person -> String
printPerson person = name person ++ " is " ++ show (age person) ++ " years old"