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


import System.Environment  
import System.IO  
import System.Directory  
  
main = do (fileName:_) <- getArgs  
          fileExists <- doesFileExist fileName  
          if fileExists  
              then do contents <- readFile fileName  
	              let fileInLines = lines contents                        
	              putStrLn $ "The file has " ++ show (length (lines contents)) ++ " lines!"
		      let tupleList = kevinMap fileInLines
                      putStrLn $ "The file has " ++ show (length (lines contents)) ++ " lines!"

              else do putStrLn "The file doesn't exist!"  


kevinMap :: [String] -> IO ()  
kevinMap [fileName, todoItem] = appendFile fileName (todoItem ++ "\n")  







