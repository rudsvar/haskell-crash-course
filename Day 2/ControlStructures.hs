------------------------------------
------------ Case of ---------------
------------------------------------
  
-- Pattern matching is used check for different cases, and to extract values
-- out of some structure

-- Lists
findLength :: [a] -> Int
findLength l = case l of
  [] -> 0
  (_:xs) -> 1 + findLength xs

-- $> findLength []
--
-- $> findLength [3, 6, 1]

doubleEveryElement :: [Int] -> [Int]
doubleEveryElement l = case l of
  [] -> []
  (x:xs) -> x * 2 : doubleEveryElement xs

-- doubleEveryElement [4, 7, 2, 1]

-- What happens if I forget a case? Note that you can run ghci with -Wall

data User = Admin String | Registered String | Guest

showUser :: User -> String
showUser u = case u of
  Admin n -> "Admin " ++ n
  Registered n -> n
  Guest -> "Visitor"

-- $> showUser (Admin "Rudi")
--
-- $> showUser (Registered "Marianne")
--
-- $> showUser Guest

fizzbuzz n = case (3 `divides` n, 5 `divides` n) of
               (True,  True ) -> "Fizzbuzz"
               (True,  False) -> "Fizz"
               (False, True ) -> "Buzz"
               (False, False) -> show n
             where divides b a = a `mod` b == 0

-- This is also possible to do with multiple function declarations
showUser' :: User -> String
showUser' (Admin n) -> "Admin " ++ n
showUser' (Registered n) -> n
showUser' Guest -> "Visitor"

----------------------------------------
-------------- Where -------------------
----------------------------------------

-- Used to declare constants and functions in the scope of a function
--
-- Useful to avoid a long unclear line of code

initials :: String -> String -> String  
initials firstname lastname = [f] ++ ". " ++ [l] ++ "."  
    where (f:_) = firstname  
          (l:_) = lastname

-- $> initials "Knut Anders" "Stokke"

----------------------------------------
-------------- Guards ------------------
----------------------------------------

qualifyInt :: Int -> String
qualifyInt i  
  | i < 0 = "Negative"
  | i > 0 = "Postive"
  | otherwise = "Neither"

-- $> qualifyInt 10
--
-- $> qualifyInt (-10)
--
-- $> qualifyInt 0

