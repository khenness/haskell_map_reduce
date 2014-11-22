
import Data.Map as Map

import Control.Monad
import System.Environment
import System.IO

import Control.Concurrent

import Data.Tuple
--import Data.List

mapReduce :: forall k1 k2 v1 v2 v3 Ord k2
          => (k1 -> v1 -> [(k2,v2)])
          -> (k2 -> [v2] -> Maybe v3)
          -> Map.Map k1 v1
          -> Map.Map k2 v3

mapReduce mAP rEDUCE = reducePerKey . groupByKey . mapPerKey
    where
	

	mapPerKey :: Map.Map k1 v1 -> [(k2,v2)]
	mapPerKey =
	    concat . Prelude.map (uncurry mAP) pairs . toList
	
	groupByKey :: [(k2,v2)] -> Map.Map k2 [v2]
	groupByKey = Prelude.foldl insert empty
	    where
		insert dict (k2,v2) = insertWith (++) k2 [v2] dict


	reducePerKey :: Map.Map k2 [v2] -> Map.Map k2 v3
	reducePerKey = mapWithKey unJust . filterWithKey isJust . mapWithKey rEDUCE
	    where
		isJust k (Just v) = True
		isJust k Nothing = False
		unJust k (Just v) = v

pairs :: [a] -> [(a, a)]
pairs [] = []
pairs [x] = []
pairs (x1:x2:xs) = (x1, x2) : pairs xs



main = print "hello"
