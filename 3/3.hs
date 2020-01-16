import System.Environment
import System.Directory
import System.IO
import Data.List

dispatch :: [(String, [String] -> IO ())]
dispatch =  [ ("add", add)
            , ("view", view)
            , ("remove", remove)
            , ("filterVowels", filterVowels)
            , ("filterByLength", filterByLineLength)
            ]

main = do
    args <- getArgs
    putStrLn "*add "
    putStrLn "*view"
    putStrLn "*remove"
    putStrLn "*filterVowels"
    putStrLn "*filterByLength"
    putStr "   Write command: "
    command <- getLine
    let (Just action) = lookup command dispatch
    action args

add :: [String] -> IO ()
add [fileName, fileName2] = do
  putStrLn "Write string: "
  str <- getLine
  appendFile fileName ("\n" ++ str ++ "\n")

view :: [String] -> IO ()
view [fileName, fileName2] = do
    contents <- readFile fileName
    putStr $ contents

remove :: [String] -> IO ()
remove [fileName, fileName2] = do
    handle <- openFile fileName ReadMode
    (tempName, tempHandle) <- openTempFile "." "temp"
    contents <- hGetContents handle
    putStrLn "write your number string: "
    numberString <- getLine
    let number = read numberString
    let contentsList = lines contents
    let lengthFile = length contentsList
    if (number - 1 > lengthFile)
    then
        putStrLn "Incorrect number."
    else do
        let newContentsList = delete (contentsList !! (number - 1)) contentsList
        hPutStr tempHandle $ unlines newContentsList
    hClose handle
    hClose tempHandle
    removeFile fileName
    renameFile tempName fileName

noVowels :: String ->String
noVowels [] = []
noVowels (x:xs)
  |not( x `elem` "aeiouAEIOU") = x: noVowels xs
  |otherwise = noVowels xs

filterVowels :: [String] -> IO ()
filterVowels [fileName1, fileName2] = do
    contents <- readFile fileName1
    print contents
    let newContents = noVowels contents
    writeFile fileName2 newContents

getLinesByLength :: String -> Int -> String
getLinesByLength input lineLength =
    let allLines = lines input
        shortLines = filter (\line -> length line < lineLength) allLines
        result = unlines shortLines
    in  result

filterByLineLength :: [String] -> IO ()
filterByLineLength [fileName1, fileName2] = do
    contents <- readFile fileName1
    print contents
    putStrLn "Write line length: "
    lineLengthStr <- getLine
    let lineLength = read lineLengthStr
    let newContents = getLinesByLength contents lineLength
    writeFile fileName2 newContents
