{- A guide to common types and their usage. -}

import Data.Char (toUpper)

-- Int

one :: Int
one = 1

three :: Int
three = one + 2

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

data MyList = Empty | Prepend Int MyList

myList1 :: MyList
myList1 = Prepend 1 (Prepend 2 Empty)

-- data [a] = [] | a : [a]
list1 :: [Int]
list1 = [1, 2, 3]
-- list1 = 1 : (2 : (3 : []))
-- list1 = 1 : 2 : 3 : []

head :: [Int] -> Int
head (x : _) = x
head []      = error "head of empty list"

tail :: [Int] -> [Int]
tail (_ : xs) = xs
tail []       = error "tail of empty list"

-- Char
charA :: Char
charA = 'a'

charB :: Char
charB = 'b'

-- ab == ab2

upperB :: Char
upperB = toUpper charB

-- String

abString :: String
abString = "ab"

abListOfChar :: [Char]
abListOfChar = [charA, charB]

stringToUpper :: String -> String
stringToUpper []        = []
stringToUpper (c : str) = toUpper c : stringToUpper str

helloWorld :: String
helloWorld = "Hello " ++ "world!"

reverseString :: String -> String
reverseString []       = []
reverseString (x : xs) = xs ++ [x]
