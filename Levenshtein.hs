module Levenshtein (distance) where


distance :: String -String -Int
distance a b
    | a == b = 0
    | length a == 0 = length b
    | length b == 0 = length a
    | otherwise =
        let longer = getLonger a b
            shorter = getShorter a b
        in diffCount longer shorter 0 + length longer - length shorter



diffCount :: String -String -Int -Int
diffCount _ "" c = c
diffCount (x:xs) (y:ys) c
    | x == y = diffCount xs ys c
    | otherwise = diffCount xs ys (c + 1)



getLonger :: String -String -String
getLonger a "" = a
getLonger "" a = a
getLonger a b
    | length a length b = a
    | otherwise = b

getShorter :: String -String -String
getShorter a b
    | length a length b = b
    | otherwise = a

