
-- Lista feladatok (take függvényt érdemes végtelen listák tesztelésére használni)
--------------------------------------------------------------------------------


-- 1. feladat: definiáljuk a listát
--    (végtelen lista)
--    (tipp: concat, replicate, map)
-- l1 :: [Int]
-- l1 = [1, 2, 2, 3, 3, 3, 4, 4, 4, 4 ...]

l1 :: [Int]
l1 = concat (map (\x -> replicate x x) [1..])
  -- 1. elõször listák listáját csináljuk:
  --   [[1], [2, 2], [3, 3, 3], [4, 4, 4, 4] ...]
  -- 2. concat-al fûzzûk össze
  -- (emlékeztetõ: [1..] az a lista: [1, 2, 3, 4...])
  -- (rövidítés, standard függvény: concatMap)
  -- (concatMap f xs = concat (map f xs))
  -- l1 = concatMap (\x -> replicate x x) [1..]

-- 2. feladat (végtelen)
-- l2 :: [Int]     -- tipp : [x..y]
-- l2 = [1, 1, 2, 1, 2, 3, 1, 2, 3, 4, 1, 2, 3, 4, 5, ...]
--
l2 :: [Int]
l2 = concat (map (\x -> [1..x]) [1..])


-- 3. feladat (végtelen lista)
-- (tipp: map)
-- l3 = [0, -1, 2, -3, 4, -5, 6, ...]
l3 :: [Int]
l2 = map (\x -> if even x then x else (-1)*x) [0..]


-- 4. feladat (osztók listája)
-- adjuk vissza listában egy szám összes osztóját
divisors :: Int -> [Int]
divisors x = filter (\y -> mod x y == 0) [1..x]
 -- mod x y  megadja a maradékot x y-al való osztása után

isPrime :: Int -> Bool
isPrime x = divisors x == [1, x]
   -- (x akkor prím, ha az összes osztója 1 és x)


-- Lista kifejezések
--------------------------------------------------------------------------------

-- (lista kifejezések: tömörített jelölés concatMap, filter, map, [x]
--  segítségével minden lista kifejezés megadható)

pairs :: [(Int, Int)]
pairs = [(x, y) | x <- [0..10], y <- [0..10], x + y < 8]
     -- matematikai halmaz jelöléshez hasonló {(x, y) | x eleme [0..10] és y
     -- eleme [0..10] és x + y < 8}

triples :: [(Int, Int, Int)]
triples = [(x, y, z) | x <- [0..5], y <- [10, 20], z <- [5, 6]]
     -- (nem adtuk meg szűrõ feltételt, csak listát)

triples' :: [(Int, Int, Int)]
triples' = [(z, y, x) | x <- [0..5], y <- [10, 20], z <- [5, 6]]
   -- (végsõ listaelemek | bal oldalán vannak,
   --  csak a | jobb oldalán említett listaelemekre hivatkozhat)
   -- (feltételek csak korábban bevezetett listaelemekre
   --    hivatkoznak)


-- példa: pitagoraszi számhármasok, ha a számok összege <100
pit :: [(Int, Int, Int)]
pit = [(x, y, z) | x <- [0..100], y <- [0..100], z <- [0..100],
                   x*x + y*y == z*z, x + y + z < 100]


-- példa map, filter, concat újradefiniálására lista kifejezéssel:

map' :: (a -> b) -> [a] -> [b]
map' f xs = [f x | x <- xs]

filter' :: (a -> Bool) -> [a] -> [a]
filter' f xs = [x | x <- xs, f x]  -- vegyük xs azon elemeit,
                                   -- amelyekre f igaz

concat' :: [[a]] -> [a]
concat' xss = [x | xs <- xss, x <- xs]
     -- vegyük az összes xs listát xss-bõl
     -- minden ilyen xs-bõl vegyük az összes x elemet
     -- a végeredmény lista elemei legyenek ezek az x-ek
