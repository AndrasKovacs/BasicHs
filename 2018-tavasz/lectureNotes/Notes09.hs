
-- scanl' :: (b -> a -> b) -> b -> [a] -> [b]
-- scanl' f b []     = [b]
-- scanl' f b (a:as) = b : scanl' f (f b a) as

------------------------------------------------------------

last' :: [a] -> a
last' [a]    = a
last' (_:as) = last' as

last'' :: [a] -> a
last'' = head . reverse

last3 :: [a] -> a
last3 = foldr1 (\_ a -> a)
     -- foldr1 const
     -- nem üres lista: (adjuk vissza a rekurzív eredményt)
     --     user lista: hiba

-- Feladat:
------------------------------------------------------------

-- rendezett összefésülés:
-- mindkét input lista rendezett
-- legyen az output lista rendezett & a két input összefésülése
-- használhatjuk: (<), (<=), compare függvényeket az elemeken
-- merge :: Ord a => [a] -> [a] -> [a]

-- merge függvényt a következőre használjuk:
-- (összefésüléses rendezés)
-- példa a működésre:

-- input [3, 2, 1, 0]
-- 1. [3, 2, 1, 0]
-- 2. [[3], [2], [1], [0]]   -- vegyük az 1-elemű listákat
-- 3. [[2, 3], [0, 1]]       --
-- 4. [[0, 1, 2, 3]]         -- páronkét összefésüljük
-- 5. [0, 1, 2, 3]           -- amíg csak egy lista nem marad
                             -- és azt visszaadjuk

-- Mindig rendezett lesz az output:
--   Egy elemű listák mindig rendezettek
--   Két rendezett lista merge-elése szintén rendezett
-- mergeSort :: Ord a => [a] -> [a]

-- nem próbáljuk rögtön rekurzívan megírni
-- 1. mergePairs :: Ord a => [[a]] -> [[a]] -- minden párt merge-el
-- 2. helper     :: Ord a => [[a]] -> [a]
       -- addíg alkalmazza mergePairs-t, amíg nem lesz egy lista
       -- a listában, és azt visszaadja

------------------------------------------------------------

merge :: Ord a => [a] -> [a] -> [a]
merge (x:xs) (y:ys)
  | x < y     = x : merge xs (y:ys)
  | otherwise = y : merge (x:xs) ys
merge xs [] = xs
merge [] ys = ys

mergePairs :: Ord a => [[a]] -> [[a]]
mergePairs (x:y:xs) = merge x y : mergePairs xs
mergePairs xs       = xs

helper :: Ord a => [[a]] -> [a]
helper [as] = as
helper as   = helper (mergePairs as)

mergeSort :: Ord a => [a] -> [a]
mergeSort = helper . map (\a -> [a])

-- extra feladat:
--   map (\a -> [a]) helyett
--   olyan függvénnyel kezdjünk, ami az emelkedő részlistákat képezi
--   hatékonyabb lesz

-- közvetlen rekurzív implementáció
runs :: Ord a => [a] -> [[a]]
runs []     = []
runs (a:as) = case runs as of
  (a':as):ass -> if a < a' then (a:a':as):ass
                           else [a]:(a':as):ass
  []          -> [[a]]

-- runs' :: Ord a => [a] -> [[a]]
-- runs' as = groupBy (<=) as

-- magasabbrendű függvénnyel: opcionális házi feladat
-- másik opcionális házi: vég-rekurzív runs implementáció
-- harmadik opcionális házi: nézzük meg Data.List.sort implemenációt
--     (ez majdnem ugyanaz, mint mergeSort')

mergeSort' :: Ord a => [a] -> [a]
mergeSort' = helper . runs
