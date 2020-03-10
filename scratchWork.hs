import Data.List (permutations)

-- want to return a function that contains rules with return values filled in from list thats gets passed in
-- need to figure out how to 

pyramidRules :: [Bool] -> Bool
pyramidRules [True, True, True] = False
pyramidRules [True, True, False] = True
pyramidRules [True, False, True] = False
pyramidRules [True, False, False] = True
pyramidRules [False, True, True] = True
pyramidRules [False, True, False] = False
pyramidRules [False, False, True] = True
pyramidRules [False, False, False] = False

merge [] ys = ys
merge (x:xs) ys = x:merge ys xs

-- eightTrue = 
-- sevenTrue =
-- sixTrue =
-- fiveTrue = 
-- fourTrue =
-- threeTrue =
-- twoTrue =
-- oneTrue =
-- zeroTrue =

listTrue :: Int -> [Bool]
listTrue x = [True | a <- [1..x]]

listFalse :: Int -> [Bool]
listFalse x = [False | a <- [1..8-x]]

truesFalses :: Int -> [Bool]
truesFalses x = (listTrue x) ++ (listFalse x)

-- for each x get all permutations of truesFalses x

-- permTrue :: [[Bool]]
-- permTrue = concat $ map permutations [truesFalses a | a<-[0..8]]

permTrue :: [[Bool]]
permTrue =  [truesFalses a | a<-[0..8]]



foo = (\x -> case x of 0 -> 10 + 1
                       1 -> 10 - 1)

-- generate allCombinations = 

-- from textbook pg 173  
filterM :: Monad m => (a -> m Bool) -> [a] -> m [a]
filterM p [] = return []
filterM p (x:xs) = do b <- p x
                      ys <- filterM p xs
                      return (if b then x:ys else ys)

powerset (x:xs) = filterM (\x -> [True, False]) (x:xs)

-- generates power set of [1..8]
powersetRulesNum = powerset [1,2,3,4,5,6,7,8]

-- takes list of numbers and converts to list of trues and falses
numsToBools xs = [ elem a xs | a <- [1..8]]

-- generates all rules
powersetRulesBool = map numsToBools powersetRulesNum
