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

alphabet :: String
alphabet = ['a' .. 'z']

oneToTen :: [Int]
oneToTen = [1 .. 10]

-- Tasks

-- absolute value of an int
absolute :: Int -> Int
absolute x = if x < 0 then -x else x

-- int with smallest value
smallest :: Int -> Int -> Int
smallest x y = if x < y then x else y

-- incrementAllBy k xs means increment all elements by k
incrementAllBy :: Int -> [Int] -> [Int]
incrementAllBy _ []       = []
incrementAllBy n (x : xs) = x + n : incrementAllBy n xs

-- change the tuple structure
changeTuple :: (Int, (Char, String)) -> ((Char, Int), String)
changeTuple (i, (c, s)) = ((c, i), s)

-- hint: show 5 = "5"
-- "FizzBuzz" if divisible by 3 and 5
-- "Fizz" if divisible by 3
-- "Buzz" if divisible by 5
-- `show x` otherwise
fizzBuzz :: [Int] -> [String]
fizzBuzz []       = []
fizzBuzz (x : xs) = if mod x 3 == 0 && mod x 5 == 0
  then "FizzBuzz" : fizzBuzz xs
  else if mod x 3 == 0
    then "Fizz" : fizzBuzz xs
    else if mod x 5 == 0 then "Buzz" : fizzBuzz xs else show x : fizzBuzz xs
-- Alternative solution
-- fizzBuzz str = map fizzOrBuzz str
--     where
--         fizzOrBuzz :: Int -> String
--         fizzOrBuzz x
--             | x `mod` 3 == 0 && x `mod` 5 == 0 = "FizzBuzz"
--             | x `mod` 3 == 0 = "Fizz"
--             | x `mod` 5 == 0 = "Buzz"
--             | otherwise = show x

isAlphabetic :: Char -> Bool
isAlphabetic c =
  let
    isLower = 'a' <= c && c <= 'z'
    isUpper = 'A' <= c && c <= 'Z'
  in isLower || isUpper
-- Alternative solution
-- isAlphabetic c = c `elem` ['a'..'Z'] || c `elem` ['A' .. 'Z']

-- hint: take, drop
substring :: Int -> Int -> String -> String
substring start end str = take (end - start) $ drop start str

combine :: [Int] -> [Char] -> [(Int, Char)]
combine []       _        = []
combine _        []       = []
combine (x : xs) (y : ys) = (x, y) : combine xs ys

enumerate :: [Char] -> [(Int, Char)]
enumerate chars = combine [0 .. length chars - 1] chars

factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n - 1)
