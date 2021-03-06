-- to compile: ghc -threaded -eventlog -rtsopts part02.hs
-- to run (windows): part02.exe big.txt +RTS -ls -N2

import System.Environment  
import System.IO
import System.Directory 
import Data.Char (toLower)
import Data.List (sort, group)
import Control.Arrow ((&&&)) 
import Data.Map as Map
import Control.Parallel
import Control.Parallel.Strategies

mapReduce
    :: Strategy b    -- evaluation strategy for mapping
    -> (a -> b)      -- map function
    -> Strategy c    -- evaluation strategy for reduction
    -> ([b] -> c)    -- reduce function
    -> [a]           -- list to map over
    -> c

-- file: ch24/MapReduce.hs
mapReduce mapStrat mapFunc reduceStrat reduceFunc input =
    mapResult `pseq` reduceResult
  where mapResult    = parMap mapStrat mapFunc input
        reduceResult = reduceFunc mapResult `using` reduceStrat

stringToWordCountMap :: String -> Map.Map String Int
stringToWordCountMap  = Map.fromList . Prelude.map (head &&& length) . group . sort . words . Prelude.map toLower 

combineWordCountMaps :: Map.Map String Int -> Map.Map String Int -> Map.Map String Int
combineWordCountMaps map1 map2 = Map.unionWith (+) map1 map2

reduceWordCountMaps :: [ Map.Map String Int] -> Map.Map String Int
reduceWordCountMaps  (x:[]) = x
reduceWordCountMaps  (x:xs) = combineWordCountMaps x (reduceWordCountMaps xs)

main = do (fileName:_) <- getArgs  
          fileExists <- doesFileExist fileName  
          if fileExists  
              then do contents <- readFile fileName  
                      let fileInLines = lines contents
                          result = mapReduce rpar stringToWordCountMap rpar reduceWordCountMaps fileInLines

                      putStrLn $ "The file has " ++ show (length (lines contents)) ++ " lines!"
                      putStrLn $ "result = " ++ show result ++ "."
              else do putStrLn "The file doesn't exist!"  