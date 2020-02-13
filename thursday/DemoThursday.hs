data NameOfMyType = ADataConstructor | AnotherDataConstructor

data MyStringWrapper = StringWrapper String

data MyTuple4 = Tuple Int Int Int Int 

data SomehowPolymorphicTuple4 a = SPTuple a a a a

data PolymorphicTuple4 a b c d = PTuple a b c d

data User = Admin String | Registered String | Guest

showUser :: User -> String
showUser u = case u of
    Admin n -> "Admin: " ++ n
    Registered n -> n
    Guest -> "Visitor"

-- showUser (Admin n) = "Admin: " ++ n 
-- showUser (Registered n) = n
-- showUser Guest = "Visitor"

data MayExist = ItExists String | ItDoesNotExist

maybeAString :: MayExist
-- maybeAString = ItExists "This is the value"
maybeAString = ItDoesNotExist

lengthOfMaybeAString = case maybeAString of
    ItExists s -> length s
    ItDoesNotExist -> -1

-- data Maybe a = Just a | Nothing
data Either a b = Left a | Right b

data BTL = Zero | Pred BTL | Succ BTL

zero = Zero
one = Succ Zero
two = Succ (Succ Zero)
-- two = Succ one
minusOne = Pred Zero

toInt :: BTL -> Int
toInt Zero = 0
toInt (Pred x) = (toInt x) - 1
toInt (Succ x) = (toInt x) + 1

-- Partial application
-- add :: Int -> Int -> Int
-- add x y = x + y

multThree :: Int -> Int -> Int -> Int
multThree x y z = x * y * z

-- Lambdas / anonymous functions

double :: Int -> Int
--double x = x * 2
double = \x -> x * 2

mult :: Int -> Int -> Int
--mult x y = x * y
--mult = \x -> \y -> x * y
mult = \x y -> x * y

first :: (a,b) -> a
--first (x,_) = x
first = \(x,_) -> x

dropGreaterThanThree :: [Int] -> [Int]
-- dropGreaterThanThree xs = filter lessThanThree xs
--dropGreaterThanThree xs = filter (\x -> x < 3) xs
dropGreaterThanThree xs = filter (< 3) xs

--lessThanThree :: Int -> Bool
--lessThanThree x = x < 3

keepEquals :: [(Int,Int)] -> [(Int,Int)]
keepEquals xs = filter (\(x,y) -> x == y) xs
 


-- (*) :: Int -> Int -> Int
-- (*) x y = x + y

(%) :: Int -> Int -> Int
(%) x y = mod x y

findLength :: [a] -> Int
findLength l = case l of
    [] -> 0
    (_:xs) -> 1 + findLength xs

-- findLength [] = 0
-- findLength (_:xs) = 1 + findLength xs

doubleEveryElement :: [Int] -> [Int]
doubleEveryElement l = case l of
    [] -> []
    (x:xs) -> x*2 : doubleEveryElement xs

initials :: String -> String -> String
initials firstname lastname =
    [f] ++ ". " ++ [l] ++ "."
    where
        (f:_) = firstname
        (l:_) = lastname

--    let
--        (f:_) = firstname
--        (l:_) = lastname
--    in
--        [f] ++ ". " ++ [l] ++ "."
--

qualifyInt :: Int -> String
qualifyInt i
    | i < 0 = "negative"
    | i > 0 = "positive"
    | otherwise = "zero"

incrementAll :: [Int] -> [Int]
incrementAll xs = map' (+ 1) xs
--decrementAll [] = []
--decrementAll (x:xs) = x - 1 : decrementAll xs

map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x:xs) = f x : map' f xs

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p (x:xs) = p x || any' p xs
-- any' p (x:xs) = case p x of
--     True -> True
--     False -> any' p xs

all' :: (a -> Bool) -> [a] -> Bool
all' _ [] = True
all' p (x:xs) = p x && all' p xs
-- all' p (x:xs) = case p x of
--     True -> all' p xs
--     False -> False


data Expr = Var String | Add Expr Expr | Mul Expr Expr

instance Show Expr where
    show (Var s) = s
    show (Add e1 e2) = show e1 ++ " + " ++ show e2
    show (Mul e1 e2) = show e1 ++ " * " ++ show e2

data List a = MakeList [a] Int
  deriving Show

-- instance Show a => Show (List a) where
--     show (MakeList xs len) = show xs ++ ", with len " ++ show len

class Addable a where
    add :: a -> a -> a

instance Addable (List a) where
    add (MakeList xs len1) (MakeList ys len2) = MakeList (xs ++ ys) (len1 + len2)

instance Addable Int where
    add i1 i2 = i1 + i2

instance Addable [a] where
    add l1 l2 = l1 ++ l2


class Creature a where
    getName :: a -> String
    getAge :: a -> Int
    isFriendly :: a -> Bool
    getInfo :: a -> String
    getInfo x = getName x ++ " is " ++ show (getAge x) ++ " years old"

data Person = P String Int
    deriving Eq

instance Creature Person where
    getName (P name age) = name
    getAge (P name age) = age
    isFriendly _ = False

data Dog = D String Int String

instance Creature Dog where
    getName (D name age owner) = name
    getAge (D name age owner) = age
    isFriendly _ = True






-- Basic IO

main :: IO ()
main = do
    -- name <- ask "What is your name?"
    -- putStrLn ("Hello, " ++ name)

    writeFile "out.txt" "Hello, file!"

    contents <- readFile "out.txt"
    putStrLn ("Read the following: " ++ show contents)

ask :: String -> IO String
ask question = do
    putStrLn question
    answer <- getLine
    return answer

readIntAndPrintIt :: IO ()
readIntAndPrintIt = do
    line <- getLine
    let number :: Int
        number = read line
    putStrLn ("Your number was: " ++ show number)

getInt :: IO Int
getInt = do
    n <- getLine
    return (read n)

getDouble :: IO Double
getDouble = do
    n <- getLine
    return (read n)

f :: IO Int
f = do
    x <- getInt
    y <- getInt
    -- return 123
    z <- getInt
    let result = x*y*z
    print result
    return result

-- data Maybe a = Nothing | Just a

maybeHead :: [a] -> Maybe a
maybeHead [] = Nothing
maybeHead (x:_) = Just x


