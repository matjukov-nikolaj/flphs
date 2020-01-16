import System.IO
import System.Environment   

-- №2
iSqrt :: Integer -> Integer
iSqrt n = floor $ sqrt $ fromInteger n
 
isSquare :: Integer -> Bool
isSquare n = (n == w*w)
             where w = iSqrt n
 
genPairs :: Integer -> [(Integer,Integer)]
genPairs n = [(k,n-k) | k <- [100,101..n `div` 2], (isSquare k), (isSquare (n-k))]
 
pifagor :: Int -> [(Integer,Integer,Integer)]
pifagor n = map (\ (x,y) -> (iSqrt x,iSqrt y,iSqrt (x + y))) w
            where w = take n $ concatMap genPairs [k*k | k <- [400,401..]]

-- №3
transpose:: [[a]]->[[a]]
transpose x = map (\n -> (map (!! n) x)) [0 .. length x]

main :: IO ()
main = do
    putStrLn "#1"
    let nums = [num | num <- [1..999], num `mod` 3 == 0 || num `mod` 5 == 0];
    print (sum nums)

    putStrLn "#2"
    let allTriples = pifagor 25
    print allTriples
    let result = filter (\(x,y,z) -> (x + y + z == 1000)) allTriples
    print (result)
    -- [(200,375,425)]
    let mult = (map (\(x,y,z) -> x*y*z) result)
    print mult

    putStrLn "#3"
    let res = transpose [[1,2,3],[4,5,6]]
    print res
