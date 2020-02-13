main = putStrLn "Hello World!"

-- Data
data NameOfMyType = ADataConstructor | AnotherDataConstructor
-- $> :t ADataConstructor
--
-- $> :t AnotherDataConstructor
--
-- $> :t NameOfMyType -- Should error
--
-- $> :i NameOfMyType

-- Data can hold other types
data MyStringWrapper = StringWrapper String
-- $> :t StringWrapper
--
-- $> :t StringWrapper "someString"

-- Data can hold many other types
data MyTuple4 = Tuple Int Int Int Int
-- $> :t Tuple
--
-- $> :t Tuple 5 10 (-1) 3

-- Data can be polymorphic
data SomehowPolymorphicTuple4 a = SPTuple a a a a 
-- $> :t SPTuple
--
-- $> :t SPTuple 5 10 (-1) 3
--
-- $> :t SPTuple (5::Int) 10 (-1) 3
--
-- $> :t SPTuple 'a' 'b' '8' '.'
--
-- $> :t SPTuple 4 'b' 8 '.'

-- Even more polymorphic
data PolymorphicTuple4 a b c d = PTuple a b c d
-- $> :t PTuple
--
-- $> :t PTuple (4::Int) 'b' (8::Double) '.'

-- Data Type can have many Data Constructors
-- This is similar to enums, if different enums also could hold data
data User = Admin String | Registered String | Guest
-- $> :t Admin
--
-- $> :t Admin "Rudi"
--
-- $> :t Registered "Marianne"
--
-- $> :t Guest


-------------------------------------------
-- Using Data Types to model your data ----
-------------------------------------------
  
-- Model a value which potentially is missing.
-- Using this instead of `null` makes the famous NullPointerException impossible
data MayExist = ItExists String | ItDoesNotExist
-- $> :t ItExists
--
-- $> :t ItExists "This is the value"
--
-- $> :t ItDoesNotExist
--
maybeAString = (ItExists "This is the value")
--
-- $> :t length maybeAString -- Should error
--
lengthOfMaybeAString = case maybeAString of
  ItExists x -> length x
  ItDoesNotExist -> -1

-- data Maybe a = Just a | Nothing

-- Model a value that might be one of two things
-- Use case: Left can hold an error message if something went wrong,
-- Right can hold the result if not
data Either a b = Left a | Right b

-- We can be even more explicit about this error type. Note that 
-- the last type variable is missing
type Error b = Main.Either String b

---------------------------------------
-- Recursively defined Data Types -----
---------------------------------------

data BTL = Zero | Pred BTL | Succ BTL

zero = Zero
one = Succ Zero
two = Succ (Succ Zero)
minusOne = Pred Zero

toInt :: BTL -> Int
toInt Zero = 0
toInt (Pred x) = toInt x - 1
toInt (Succ x) = toInt x + 1

-- $> toInt zero
--
-- $> toInt one
--
-- $> toInt two
--
-- $> toInt minusOne

isZero :: BTL -> Bool
isZero x = toInt x == 0


