-- % Basic IO

module BasicIO where

-- Writing `main`

main :: IO ()
-- main = putStrLn "Hello, World!"
main = do
  putStrLn "What is your name?"
  name <- getLine :: IO String
  putStrLn ("Hello, " ++ name)

  readFileExample
  writeFileExample

-- What are the types of these things?
-- putStrLn :: String -> IO ()
-- getLine :: IO String

-- How do we extract these values? With the arrow!
-- str :: String <- getLine :: IO String

ask :: String -> IO String
ask question = do
  putStrLn question
  response <- getLine
  return response

-- Reading from a file
readFileExample :: IO ()
readFileExample = do
  fileContent <- readFile "BasicIO.hs"
  putStrLn fileContent

-- Writing to a file
writeFileExample :: IO ()
writeFileExample = do
  putStrLn "Starting write to file..."
  writeFile "out.txt" "Hello, file!\n"
  putStrLn "Done writing to file."
