
-- Következõ héten: gyakorlaton próba zh.
--   90 perc, 10 feladat
--   (vizsga: 120 perc)
-- Péntek 12:00 - 14:00 konzultáció

-- input listák rendezettek (nem csökkenők) adjunk vissza [Int] listát, ami a
-- bemenő listák elemeit tartalmazza, és rendezett.
merge :: [Int] -> [Int] -> [Int]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys) | x < y     = x : merge xs (y:ys)
                    | otherwise = y : merge (x:xs) ys

-- példa: merge [0, 1] [2, 5] == [0, 1, 2, 5]
--        merge [0, 3] [1, 10] == [0,1, 3, 10]
--        merge [10] [] == [10]
--        merge [1, 1, 3, 5] [0, 0, 10] == [0, 0, 1, 1, 3, 5, 10]


-- 2. feladat:
-- partition :: (a -> Bool) -> [a] ->([a],[a])
-- adjunk vissza két olyan listát, hogy az elsõ
-- lista minden elemére igaz a bemenõ feltétel,
-- és a második lista minden elemére hamis
-- pl: partition (\x -> x < 10) [0, 3, 12, 11]
--      == ([0, 3], [12, 11])

partition1 :: (a -> Bool) -> [a] -> ([a], [a])
partition1 f [] = ([], [])
partition1 f (x:xs) = if f x then (x:ys, zs) else (ys, x:zs)
  where (ys, zs) = partition1 f xs

partition2 :: (a -> Bool) -> [a] -> ([a], [a])
partition2 f [] = ([], [])
partition2 f (x:xs) = case partition2 f xs of
  (ys, zs) -> if f x then (x:ys, zs) else (ys, x:zs)

partition3 :: (a -> Bool) -> [a] -> ([a], [a])
partition3 f xs = (filter f xs, filter (\x -> not (f x)) xs)


-- 3. feladat:
-- dropUntil :: (a -> Bool) -> [a] -> [a]
-- hagyjuk el [a] elemeit amíg az (a -> Bool)
-- feltétel hamis, az elsõ elemnél, ahol igaz,
-- adjuk vissza a listát
-- (megjegyzés: dropWhile módosítása)
-- dropUntil (\x -> x == 0) [1, 2, 3, 0, 1]
--         == [0, 1]
dropUntil :: (a -> Bool) -> [a] -> [a]
dropUntil f [] = []
dropUntil f (x:xs) | f x       = x:xs
                   | otherwise = dropUntil f xs

-- 4. feladat:
-- zarojel :: String -> String
-- tegyük fel, hogy egy nyitó és záró zárójel
-- van az input String-ben (elõször nyitó)
-- adjuk vissza a zárójellel bezárt részét
-- a bement String-nek
-- zarojel "aaaa(bbb)cc" == bbb
-- zarojel "(macska)" == macska
-- (tipp: dropWhile, takeWhile)
zarojel1 :: String -> String
zarojel1 str = takeWhile (\x -> x /= ')') (tail (dropWhile (\x -> x /= '(') str))

-- három függvény kompozíciójaként is megadható
-- emélkezzünk: (f . g) = \x -> f (g x)
zarojel2 :: String -> String
zarojel2 = takeWhile (\x -> x /= ')') . tail . dropWhile (\x -> x /= '(')
