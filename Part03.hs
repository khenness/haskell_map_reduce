-- to compile: ghc -threaded -eventlog -rtsopts part03.hs
-- to run (windows): part03.exe big.txt +RTS -ls -N2

import System.Environment  
import System.IO
import System.Directory 
import Data.Char (toLower)
import Data.List (sort, group)
import Control.Arrow ((&&&)) 
import Data.Map as Map
import Data.List.Split
import Control.Parallel
import Control.Parallel.Strategies as Strat

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

chunkToWordCountMap :: [String] -> Map.Map String Int
chunkToWordCountMap  = Map.fromList . parMap rseq (head &&& length) . group . sort . words . Prelude.map toLower . concat



combineWordCountMaps :: Map.Map String Int -> Map.Map String Int -> Map.Map String Int
combineWordCountMaps map1 map2 = Map.unionWith (+) map1 map2


reduceWordCountMaps :: [Map.Map String Int] -> Map.Map String Int
reduceWordCountMaps  (x:[]) = x
reduceWordCountMaps (x:xs) = combineWordCountMaps x (reduceWordCountMaps xs)


main = do (fileName:_) <- getArgs  
          fileExists <- doesFileExist fileName  
          if fileExists  
              then do contents <- readFile fileName  
                      let fileInChunks = chunksOf 500 $ lines contents
                          result = mapReduce rpar chunkToWordCountMap rpar reduceWordCountMaps fileInChunks

                      --putStrLn $ "The file has " ++ show (length (lines contents)) ++ " lines!"
                      putStrLn $ "result = " ++ show result ++ "."
              else do putStrLn "The file doesn't exist!"  