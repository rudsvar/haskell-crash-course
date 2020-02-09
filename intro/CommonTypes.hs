{- A guide to common types and their usage. -}

import Data.Char (toUpper)

-- Int

one :: Int
one = 1

three :: Int
three = one + 2

successor :: Int -> Int
successor x = x + 1

predecessor :: Int -> Int
predecessor x = x - 1

one' :: Int
one' = div 3 2

-- Float

twoPointThree :: Float
twoPointThree = 2.4

onePointTwo :: Float
onePointTwo = twoPointThree / 2

-- Conversion between them can be done with fromInteger, floor, ceiling, round

-- Bool

haskellIsFun :: Bool
haskellIsFun = True

pizzaToday :: Bool
pizzaToday = False

-- Tuples

intBool :: (Int, Bool)
intBool = (5, True)

swap :: (Int, Bool) -> (Bool, Int)
swap (i, b) = (b, i)

first :: (Int, Bool) -> Int
first (i, _) = i

second :: (Int, Bool) -> Bool
second (_, b) = b

-- List

-- data [a] = [] | a : [a]
data MyList = Empty | Prepend Int MyList

myList1 :: MyList
myList1 = Prepend 1 (Prepend 2 Empty)

list1 :: [Int]
list1 = [1, 2, 3]
-- list1 = 1 : (2 : (3 : []))
-- list1 = 1 : 2 : 3 : []

myHead :: [Int] -> Int
myHead (x : _) = x
myHead []      = error "head of empty list"

myTail :: [Int] -> [Int]
myTail (_ : xs) = xs
myTail []       = error "tail of empty list"

-- Char
charA :: Char
charA = 'a'

charB :: Char
charB = 'b'

upperB :: Char
upperB = toUpper charB

-- String ([Char])

abString :: String
abString = "ab"

abListOfChar :: [Char]
abListOfChar = ['a', 'b']

helloWorld :: String
helloWorld = "Hello " ++ "world!"