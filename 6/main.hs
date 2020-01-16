import System.IO
import System.Environment   
import Boat  
import Data.Array

main = do

    putStrLn "#1" 
    showSolution (listArray (Wolf, Farmer) [L, L, L, L]) (listArray (Wolf, Farmer) [R, R, R, R])
    putStrLn ""

    --putStrLn "#2"
    --showSolution
    --Зависает из-за того что волк съедает козу или коза съедает капусту
    --putStrLn ""

    putStrLn "#3"
    showSolution (listArray (Wolf, Farmer) [L, L, R, L]) (listArray (Wolf, Farmer) [R, R, R, R])
    putStrLn ""

    putStrLn "#4"
    showSolution (listArray (Wolf, Farmer) [L, L, L, L]) (listArray (Wolf, Farmer) [R, R, L, R])
    putStrLn ""

    putStrLn "#5"
    showSolution (listArray (Wolf, Farmer) [L, R, L, L]) (listArray (Wolf, Farmer) [R, R, R, R])
    putStrLn ""

