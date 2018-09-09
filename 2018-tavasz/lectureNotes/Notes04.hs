-- tarjáni martin dominik

{-# options_ghc -fwarn-incomplete-patterns #-}
-- ezzel lehet warning-ot bekapcsolni a fájra


-- !! -- próbáljuk kerülni
      -- azért mert gyakran kvadratikus
-- kiveszi össze páros indexű elemet

evenIndices :: [a] -> [a]
evenIndices as =
  [as !! i | i <- [0..length as - 1], mod i 2 == 0]

-- komplexitása (as !! i) műveletnek: O(i)
-- tehát: evenIndices: négyzetes

evenIndices' :: [a] -> [a]
evenIndices' as = [a | (a, i) <- zip as [0..], even i]
-- evenIndices' : lineáris komplexitású

-- Listafüggvény folytatás
----------------------------------------

-- 1. lista összefűzés (++)
-- append :: [a] -> [a] -> [a]
-- append as1 []      = as1
-- append as1 (a:as2) = append (as1 ++ [a]) as2
-- ez a verzió kvadratikus!
-- + használja a standard ++-t

-- append: az első argumentum hosszával arányos futásidejű
append :: [a] -> [a] -> [a]
append []      as2 = as2
append (a:as1) as2 = a : append as1 as2

-- összefűzi az összes listát egy listává
concat' :: [[a]] -> [a]
concat' []       = []
concat' (as:ass) = as ++ concat' ass

-- egymást követő párok listáját adjuk vissza
-- consecutive [0, 1, 2, 3] == [(0, 1), (1, 2), (2, 3)]
consecutive :: [a] -> [(a, a)]
consecutive as = zip as (drop 1 as)

-- as        == [0, 1, 2, 3]
-- drop 1 as == [1, 2, 3]
--               0  1  2
--               1  2  3
-- zip as (drop 1 as) == [(0, 1), (1, 2), (2, 3)]

isAscending :: [Int] -> Bool
isAscending as =
  -- null (filter (\(a1, a2) -> a1 > a2) (consecutive as))
  all (\(a1, a2) -> a1 <= a2) (consecutive as)

-- null : [a] -> Bool
-- üres-e a lista?

-- all : igaz-e egy feltétel a lista minden elemére?
-- all :: (a -> Bool) -> [a] -> Bool

-- any :: igaz-e egy feltétel valamely listaelemre?

-- figyelmeztetés: ez nem egy teljes függvény
-- (azaz: dobhat kivételt)
last' :: [a] -> a
last' [a]    = a
last' (_:as) = last' as

-- [a]
-- Maybe a: olyan típus: ami vagy "null" vagy pedig egy a-típusú
-- elem

-- biztonságos last definíció:
-- last' :: [a] -> Maybe a
-- ha üres az input, akkor Nothing-ot ad vissza
-- (nem anyag: lehet definiálni nagyon sokféle típusokat)
-- (anyag: tuple-ok, listák, számok)

-- Rendezés ([Int] rendezés)
------------------------------------------------------------

-- insertion sort (beszúrásos rendezés)
insert :: Int -> [Int] -> [Int] -- rendezett listába beszúrás
insert n []      = [n]
insert n (n':ns) = if n < n' then n:n':ns else n' : insert n ns
-- mindig gondoljunk (először) arra,
-- hogy min történik rekurzív hívás

-- informálisan leírhatjuk a megoldást:
-- menjünk végig a lista elemein, amíg nem találunk
-- n-nél nagyobb számot, ott pedig szúrjuk be n-t.
isort :: [Int] -> [Int]
isort []     = []
isort (n:ns) = insert n (isort ns)

-- viszont: beszúró rendezés négyzetes komplexitású

-- "gyors" rendezés
qsort :: [Int] -> [Int]
qsort []     = []
qsort (n:ns) = qsort smaller ++ [n] ++ qsort greater
  where
    -- kisebbek mint n
    smaller = [n' | n' <- ns, n' < n]
    -- nagyobb  mint n
    greater = [n' | n' <- ns, n' >= n]

-- jobb verzió: partition segítségével

qsort' :: [Int] -> [Int]
qsort' []     = []
qsort' (n:ns) = qsort' smaller ++ [n] ++ qsort' greater
  where
    (smaller, greater) = partition (\n' -> n' < n) ns

-- partition: bontsunk szét egy listát két listára,
-- az első output lista minden elemére igaz egy feltétel,
-- a második output lista minden elemére hamis
partition :: (a -> Bool) -> [a] -> ([a], [a])
partition f []     = ([], [])
partition f (a:as) = if f a then (a:as1, as2) else (as1, a:as2)
  where (as1, as2) = partition f as

-- permutáció
------------------------------------------------------------

insertions :: a -> [a] -> [[a]]
insertions a []      = [[a]]
insertions a (a':as) =
  -- (a:a':as) : [a':ins | ins <- insertions a as]
  (a:a':as) : map (\ins -> a':ins) (insertions a as)

-- feladat: input lista minden minden permutációját adjuk vissza
permutations :: [a] -> [[a]]
permutations []     = [[]]
permutations (a:as) = concatMap (insertions a) (permutations as)

-- ötlet: szúrjuk be a-t as' minden elemébe minden lehetséges
-- pozícióba

-- "hatványhalmaz"
------------------------------------------------------------

-- adjuk vissza az összes lehetséges kisebb/egyenlő hosszú
-- listát (elemek sorrendjének tartásával)
power :: [a] -> [[a]]
power []     = [[]]
power (a:as) =
  let as' = power as in as' ++ map (\as' -> a: as') as'

-- választás: vagy elhagykjuk a-t az eredményből,
-- vagy pedig megtartjuk
