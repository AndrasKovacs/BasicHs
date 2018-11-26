
-- Lista feladatok
------------------------------------------------------------

-- Listák komibnációi

-- standard függvény: concatMap
concatMap' :: (a -> [b]) -> [a] -> [b]
concatMap' f xs = concat (map f xs)
  -- input lista minden elemére megadunk egy listát (f függvény segítségével)
  -- concat-al : összefûzzük az összes eredmény listát egy listává

-- példa 1.
-- vegyük a [(Int, Int)] listát, ami tartalmazza,
-- az összes lehetséges párt, ha az Int-ek 0 és 10 között
-- vannak

-- emlékeztetõ: [0..10] megadja 0 és 10 között számok listáját (inkluzív)
pairs :: [(Int, Int)]
pairs =
  concatMap (\x -> map (\y -> (x, y)) [0..10]) [0..10]

  -- 1. [0..10] lista minden elemére létrehozzunk
  --    egy listát

  -- spoiler: [(x, y) | x <- [0..10], y <- [0..10]]   (elõadáson említve volt)
pairs' :: [(Int, Int)]
pairs' = [(x, y) | x <- [0..10], y <- [0..10]]
  -- lista kifejezés / lista generátor
  -- matematikai halmaz jelöléshez szeretne hasonlítani
  -- pl: {x | x ∈ A, y ∈ A}
  -- esetünkben: {(x, y) | x ∈ [0, 10], y ∈ [0, 10]}


-- triples :: [(Int, Int, Int)]
triples = [(x, y, z) | x <- [0..3], y <- [0..3], z <- [0..3]]
  -- (akárhány lista elemeit vehetjük, vesszõvel elválasztva)

-- szűrõ feltételek: Bool kifejezéseket írhatunk | után
-- (filter függvény rövidítése)
filteredPairs :: [(Int, Int)]
filteredPairs = [(x, y) | x <- [0..10], y <- [0..10], x + y < 8]
  -- összes (x, y) kombináció, ahol (x + y) < 8

-- jegyezzük meg: lista kifejezés mindig kifejezhetõ concatMap, map, filter, és
-- egyelemű lista képzés ([x]) segítségével, viszont lista kifejezéssel gyakran
-- tömörebbek és egyszerűbbek a megoldások.

-- egyszerű példa: lista kifejezés map és filter segítségével
-- páros számok 0-tól 100-ig
nums :: [Int]
nums = filter (\x -> even x) [0..100]   -- vagy: \x -> mod x 2 == 0

        -- [x | x <- [0..100], even x]
        --  (filter: egy lista elemeit vesszük, feltétellel)

-- elsõ 100 négyzetszám
squares :: [Int]
squares = map (\x -> x * x) [0..100]
        -- [x * x | x <- [0..100]]

-- 100-ig négyzetszámok
-- nem filter-t érdemes használni (vagy pedig lista feltételt)
squaresBelow100 :: [Int]
squaresBelow100 = takeWhile (\x -> x < 100)
                            (map (\x -> x * x) [0..])
   -- elmlékeztetõ: [0..] végtelen lista, [0, 1, 2, ...]

-- [(x, y) | x <- [0..10], y <- [0..10], x + y < 8]
-- [(x, y) | x <- [0..10], even x, y <- [0..10]]

-- (listaelemek és feltételek keverve is lehetnek, de mindig csak a korábban már
--  bevezetett elemekre hivatkozhatunk)

-- (nem anyag: minél inkább balra teszünk egy feltételt, annál hatékonyabban
--  értékelõdik ki az eredmény)

-- feladat 1: pitagoraszi hármas: olyan számhármas, hogy x^2 + y^2 ==
-- z^2. Vegyük az össes ilyen hármast, amelyekre (x + y + z) < 100
l1 :: [(Int, Int, Int)]
l1 = [(x, y, z) | x <- [0..100], y <- [0..100], z <- [0..100], x*x + y*y == z*z, x+y+z < 100]

-- feladat 2: írjunk egy függvényt, ami eldönti, hogy egy szám prím.
isPrime :: Int -> Bool
isPrime x = length [y | y <- [2..x-1], mod x y == 0] == 0
  -- 1. megadjuk az osztók listáját
  -- 2. megnézzük, hogy üres-e

  -- üres lista vizsgálata másképp:
  --   null [y | y <- [2..x-1], mod x y == 0]

  -- mintaillesztéssel:
  --   case [y | y <- [2..x-1], mod x y == 0] of
  --     [] -> True
  --     _  -> False

-- feladat 3: állítsuk elõ a következõ listát:
-- l2 :: [Int]
-- l2 = [1, -2, 3, -4, 5, -6, 7, -8 ....]
-- (végtelen lista, tesztelhetjük pl. take függvénnyel)
-- (tipp: zip/zipWith függvényt is lehet használni)

l2a :: [Int]
l2a = map (\x -> if even x then x*(-1) else x) [1..]
l2b = map (\x -> x*(-1)^(x + 1)) [1..]
l2b' = [x*(-1)^(x + 1) | x <- [1..]]


-- zipWith-es megoldás:
-- (cycle: standard függvény: végtelenül ismétel egy listát)
cycle' :: [a] -> [a]
cycle' xs = concat (repeat xs)

l2c = zipWith (*) (cycle [1,-1]) [1..]


-- feladat 4: adjuk meg a listát:
-- l3 = [0, 0, 1, 0, 1, 2, 0, 1, 2, 3, 0, 1, 2, 3, 4, ...]
l3 :: [Int]
l3 = concatMap (\x -> [0..x]) [0..]
