
-- When GHC is not able to infer your types
readIntAndPrintIt :: IO ()
readIntAndPrintIt  = do
  line <- getLine
  let number = read line
  putStrLn ("Your number was: " ++ show (number :: Int)) 
-- Note the explicit type annotation here!

-- What does (IO a) mean?

-- It means that it interacts with the outside world, and then returns something of type a

-- (IO Int) interacts with the outside world and returns and Int 
getInt :: IO Int
getInt = do
  n <- getLine
  return (read n)

-- (IO Char) interacts with the outside world and returns and Char
getDouble :: IO Double
getDouble = do
  c <- getLine
  return (read c)

-- What if we don't want to return anything, like with print? IO ()
printHello :: IO ()
printHello = do
  print "Hello!"
  return () -- This line can be dropped

-- When a function returns (IO a), it is no longer pure (remember definition of pure)

-- It is NOT possible to get the value out of (IO a) in a pure function
-- You have to make the other function impure too

-- To get the value out of (IO a), we use '<-' in a do block
double :: IO ()
double = do
  n <- getInt
  print (n+n)

-- return is not a haskell keyword that goes out of a function
-- return is a function that takes something of type a returns an (IO a)
-- It wraps it in an IO context

-- Write this first without the returns in between
getThreeInts :: IO [Int]
getThreeInts = do
  a <- getInt
  -- return "Some random stuff"
  b <- getInt
  -- return 1234
  c <- getInt
  -- return 'x'
  return [a, b, c]

-- What if I dont care about the value
getAnIntAndDoNothingWithIt :: IO ()
getAnIntAndDoNothingWithIt = do
  getInt
  return ()

-- IO is designed so that you can perfectly use it without understanding everything.
-- If you want to understand everything, read up on Monads. (This is hard to grasp!)
