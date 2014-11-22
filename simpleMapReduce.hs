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




stringToWordCountTupleList :: String -> Map.Map String Int
stringToWordCountTupleList  = Map.fromList . Prelude.map (head &&& length) . group . sort . words . Prelude.map toLower 


{- gives wrong output-}
{-
combineWordCountTupleLists :: [(String, Int)] -> [(String, Int)] -> [(String, Int)]
combineWordCountTupleLists [] l = l
combineWordCountTupleLists l [] = l
combineWordCountTupleLists ((word1, count1):xs) ((word2, count2):ys) 
				| count1 == count2 = (word1, count1+count2) : combineWordCountTupleLists xs ys
				| otherwise =  combineWordCountTupleLists ((word1, count1):xs) ys
-}


combineWordCountTupleLists :: Map.Map String Int -> Map.Map String Int -> Map.Map String Int
combineWordCountTupleLists map1 map2 = Map.unionWith (+) map1 map2


--(String, Int) -> (String, Int) -> Bool




--main = print $ combineWordCountTupleLists (Map.fromList [("hello", 1),("world",1)]) (Map.fromList [("hello", 1),("dave",1),("I", 1),("am",1),("HAL", 1),("world",1)])




main = print $ stringToWordCountTupleList "hello dave I am HAL world"

{-
 
main = 

let result = simpleMapReduce stringToWordCountTupleList combineWordCountTupleLists fileInLines
writetoFile result







--function that takes a string and turns it into a word, count tuple list
--stringToWordCountTupleList

--function2 :: [(word, count)] -> [(word, count)] -> [(word, count)]
--combineWordCountTupleLists


import System.Environment  
import System.IO  
import System.Directory 
import Data.Char (toLower)
import Data.List (sort, group)
import Control.Arrow ((&&&)) 
  
main = do (fileName:_) <- getArgs  
          fileExists <- doesFileExist fileName  
          if fileExists  
              then do contents <- readFile fileName  
	              let fileInLines = lines contents
                          fileInWords = map words fileInLines --2d array of words
                          fileInWordCountTuples = map wordCount fileInWords
                          wordCountList = kevinReduce fileInWordCountTuples
                      putStrLn $ "The file has " ++ show (length (lines contents)) ++ " lines!"
		      putStrLn $ "wordCountList = " ++ show wordCountList ++ "."
		--write wordCountList to a file or something

              else do putStrLn "The file doesn't exist!"  



main = do (fileName:_) <- getArgs  
          fileExists <- doesFileExist fileName  
          if fileExists  
              then do contents <- readFile fileName  
	              let result = lines contents
                          fileInWords = map words fileInLines --2d array of words
                          fileInWordCountTuples = map wordCount fileInWords
                          wordCountList = kevinReduce fileInWordCountTuples
                      putStrLn $ "The file has " ++ show (length (lines contents)) ++ " lines!"
		      putStrLn $ "wordCountList = " ++ show wordCountList ++ "."
		--write wordCountList to a file or something

              else do putStrLn "The file doesn't exist!" 

-} 

