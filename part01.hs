-- to compile: ghc part01.hs
-- to run ./part01 testfile.txt


import System.Environment  
import System.IO  
import System.Directory 
import Data.Char (toLower)
import Data.List (sort, group)
import Control.Arrow ((&&&)) 
import Data.Map as Map


simpleMapReduce
    :: (a -> b)      -- map function
    -> ([b] -> c)    -- reduce function
    -> [a]           -- list to map over
    -> c             -- result
simpleMapReduce mapFunc reduceFunc  = reduceFunc . Prelude.map mapFunc  


stringToWordCountMap :: String -> Map.Map String Int
stringToWordCountMap  = Map.fromList . Prelude.map (head &&& length) . group . sort . words . Prelude.map toLower 


combineWordCountMaps :: Map.Map String Int -> Map.Map String Int -> Map.Map String Int
combineWordCountMaps map1 map2 = Map.unionWith (+) map1 map2


reduceWordCountMaps :: [Map.Map String Int] -> Map.Map String Int
reduceWordCountMaps  (x:[]) = x
reduceWordCountMaps (x:xs) = combineWordCountMaps x (reduceWordCountMaps xs)


main = do (fileName:_) <- getArgs  
          fileExists <- doesFileExist fileName  
          if fileExists  
              then do contents <- readFile fileName  
	              let fileInLines = lines contents
			  result = simpleMapReduce stringToWordCountMap reduceWordCountMaps fileInLines
                      putStrLn $ "The file has " ++ show (length (lines contents)) ++ " lines!"
		      putStrLn $ "result = " ++ show result ++ "."

              else do putStrLn "The file doesn't exist!"  

