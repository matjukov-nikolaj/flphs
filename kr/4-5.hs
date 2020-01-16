import System.Environment
import System.Directory
import System.IO
import Data.List

dispatch :: [(String, [String] -> IO ())]
dispatch =  [ ("filterLinesByWord", filterLinesByWord)
              , ("checkBrackets", checkBrackets)
            ]

main = do
    args <- getArgs
    putStrLn "*filterLinesByWord"
    putStrLn "*checkBrackets"
    putStr "   Write command: "
    command <- getLine
    let (Just action) = lookup command dispatch
    action args

getLinesByLength :: String -> String -> String
getLinesByLength input word =
    let allLines = lines input
        res = filter (\line -> word `isInfixOf` line) allLines
        result = unlines res
    in  result

filterLinesByWord :: [String] -> IO ()
filterLinesByWord [fileName1, fileName2] = do
    contents <- readFile fileName1
    print contents
    putStrLn "Write word: "
    word <- getLine
    let newContents = getLinesByLength contents word
    writeFile fileName2 newContents

isCorrectNestingOfBrackets :: String -> Int -> Bool
isCorrectNestingOfBrackets [] counter = counter == 0
isCorrectNestingOfBrackets (x:xs) counter | counter < 0 = False
                              | x == '(' = isCorrectNestingOfBrackets xs (counter+1)
                              | x == ')' = isCorrectNestingOfBrackets xs (counter-1)
                              | otherwise = isCorrectNestingOfBrackets xs counter
checkBrackets :: [String] -> IO ()
checkBrackets [fileName1, fileName2] = do
    contents <- readFile fileName1
    let allLines = lines contents
    let str = concat (intersperse " " allLines)
    let result = isCorrectNestingOfBrackets str 0
    print result