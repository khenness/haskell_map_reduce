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

--bad function name
stringToWordCountTupleList :: String -> Map.Map String Int
stringToWordCountTupleList  = Map.fromList . Prelude.map (head &&& length) . group . sort . words . Prelude.map toLower 

--bad function name
combineWordCountTupleLists :: Map.Map String Int -> Map.Map String Int -> Map.Map String Int
combineWordCountTupleLists map1 map2 = Map.unionWith (+) map1 map2

--bad function name
kevinReduce :: [Map.Map String Int] -> Map.Map String Int
--kevinReduce [] = []
kevinReduce  (x:[]) = x
kevinReduce (x:xs) = combineWordCountTupleLists x (kevinReduce xs)

main = do (fileName:_) <- getArgs  
          fileExists <- doesFileExist fileName  
          if fileExists  
              then do contents <- readFile fileName  
	              let fileInLines = lines contents
			  result = simpleMapReduce stringToWordCountTupleList kevinReduce fileInLines
                      putStrLn $ "The file has " ++ show (length (lines contents)) ++ " lines!"
		      putStrLn $ "result = " ++ show result ++ "."

              else do putStrLn "The file doesn't exist!"  

