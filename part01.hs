--Kevin Hennessy
--Haskell Assignment 1
--GHC commands: ""


--PARALELL version from lecture notes

--import Control.Parallel
--mapReduce :: Strategy b -> (a->b) -> Strategy c -> ([b] -> c) -> [a] -> c
--mapReduce mapStrat mapFunc reduceStrat reduceFunc input = mapResult ‘pseq‘ reduceResult
--where
--   mapResult = parMap mapStrat mapFunc input 
--   reduceResult = reduceFunc mapResult ‘using‘ reduceStrat
--
--main = print $ fib 4 4
--
--main = mapReduce divideFileByLine




--CONCURRANT version from lecture notes


--Can your programming language do this? article- http://www.joelonsoftware.com/items/2006/08/01.html
--http://cs680.cs.usfca.edu/assignments/parallel-word-count


{-import System.IO  
import System.Directory  
import Data.List  
  
main = do        
    handle <- openFile "todo.txt" ReadMode  
    (tempName, tempHandle) <- openTempFile "." "temp"  
    contents <- hGetContents handle  
    let todoTasks = lines contents     
        numberedTasks = zipWith (\n line -> show n ++ " - " ++ line) [0..] todoTasks     
    putStrLn "These are your TO-DO items:"  
    putStr $ unlines numberedTasks  
    putStrLn "Which one do you want to delete?"     
    numberString <- getLine     
    let number = read numberString     
        newTodoItems = delete (todoTasks !! number) todoTasks     
    hPutStr tempHandle $ unlines newTodoItems  
    hClose handle  
    hClose tempHandle  
    removeFile "todo.txt"  
    renameFile tempName "todo.txt"  -}

{- program to count the lines in a file.
import System.Environment  
import System.IO  
import System.Directory  
  
main = do (fileName:_) <- getArgs  
          fileExists <- doesFileExist fileName  
          if fileExists  
              then do contents <- readFile fileName  
                      putStrLn $ "The file has " ++ show (length (lines contents)) ++ " lines!"  
              else do putStrLn "The file doesn't exist!"  
-}
{-
import System.Environment  
import System.IO  
import System.Directory  
  
main = do (fileName:_) <- getArgs  
          fileExists <- doesFileExist fileName  
          if fileExists  
              then do 
		     putStrLn $ "The file has " ++ show (length ( getFileLines fileName)) ++ " lines!"
		     
  		      --kevinMap 
              else do putStrLn "The file doesn't exist!"  



getFileLines :: String -> [String]
getFileLines fileName =  do 
		  contents <- readFile fileName
                  let fileInLines = lines contents
		  return fileInLines  

-}

{-

kevinMap :: [String] -> IO ()  
kevinMap [fileName, todoItem] = appendFile fileName (todoItem ++ "\n")  


kevinReduce :: [String] -> IO ()  
kevinReduce [fileName, todoItem] = appendFile fileName (todoItem ++ "\n")  


-}

{-
--function to transform a string to 
countWordsInLine :: [String] -> [(String,Int)]
countWordsInLine [] = 
countWordsInLine (x:xs) = 
-}


                      --transformedFile = kevinMap countWords fileInWords
                          
	              --putStrLn $ "The file has " ++ show (length (lines contents)) ++ " lines!"
		      --let tupleListList = kevinMap countWordsInLine fileInLines
                      --putStrLn $ "The file has " ++ show (length (lines contents)) ++ " lines!"



import System.Environment  
import System.IO  
import System.Directory  
  
main = do (fileName:_) <- getArgs  
          fileExists <- doesFileExist fileName  
          if fileExists  
              then do contents <- readFile fileName  
	              let fileInLines = lines contents
                          fileInWords = kevinMap words fileInLines --2d array of words
                          fileInWordCountTuples = kevinMap wordCount fileInWords
                          wordCountList = kevinReduce fileInWordCountTuples
                      putStrLn $ "The file has " ++ show (length (lines contents)) ++ " lines!"
		      putStrLn $ "wordCountList = " ++ show wordCountList ++ "."
		--write wordCountList to a file or something

              else do putStrLn "The file doesn't exist!"  





kevinMap :: (a -> b) -> [a] -> [b]
kevinMap _ [] = []
kevinMap f (x:xs) = (f x : kevinMap f xs)


kevinReduce :: (a->a->a)-> [a] -> a
kevinReduce _ [] = []
kevinReduce f (x0:xs) = f x0 kevinReduce f xs 



stringToWordCountTuple :: String -> (String, Int)
stringToWordCountTuple s =
    let wordList = words s

    in 


wordCountTupleListCombine :: [(String, Int)] -> [(String, Int)] -> [(String, Int)]
wordCountTupleListCombine l [] = l
wordCountTupleListCombine [] l = l
wordCountTupleListCombine = 


wordCountTupleListCombine ((word1,count1):xs) ((word2,count2):ys) =
                           | word1 == word2 = (word1, count1+count2) : wordCountTupleListCombine xs ys
                           | otherwise 





(word2, count2) 
                                      | word1 == word2 = (word1, count1+count2)
                                      | otherwise 


                                           if word1 == word2 
                                           then (word1, count1+count2)
                                           else ()  






kevinReduce [fileName, todoItem] = appendFile fileName (todoItem ++ "\n")  


wordCount :: [a] -> [b]
wordCount [] = []
wordCount (x:xs) = ((x, countOccurances x xs):wordCount xs)

countOccurances :: String -> [String] -> Int
countOccurances word (x:xs) = sum if (word == x) then  
















