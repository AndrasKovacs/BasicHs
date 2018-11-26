

-- Következõ hét:
--   próbazh: 90 perc, 10 feladat
--       (gyakorlati teljesítéshez kell, eredmény mindegy)
--   (vizsga: 120 perc)
--   péntek 12:00 - 14:00  KONZULTÁCIÓ
--
-- (utolsó hét: próbazh-val kapcs, vizsgával kapcs. kérdések)
-- (diákat elküldöm + feleletválasztós mintasor lesz elérhető)

--------------------------------------------------------------------------------

-- 1. feladat:
-- rendezett (nem csökkenõ) lista inputok
-- adjunk vissza rendezett [Int] outputot, ami a bemenõ
-- listák elemeit tartalmazza
-- merge :: [Int] -> [Int] -> [Int]
-- példa: merge [0, 1] [3, 4] == [0, 1, 3, 4]
--        merge [1, 4] [3, 5, 7] == [1, 3, 4, 5, 7]

-- megoldás: két lista elejérõl mindig vegyük a kisebbik elemet,
-- addig, amíg a két lista közul valamelyik üres nem lesz

-- (imperatívan: két lista elsõ elemeit vizsgáljuk, a kisebbet
--  levesszük és az eredménybe tesszük, ezt addig csináljuk,
--  amíg valamelyik input lista üres lesz)

merge :: [Int] -> [Int] -> [Int]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys) | x < y     = x : merge xs (y:ys)
                    | otherwise = y : merge (x:xs) ys


-- 2. feladat:
-- zarojel :: String -> String
-- legyen a bemenet egy String, amiben van egy nyitó és egy csukó
-- zárójel (a nyitó elõször). Adjuk vissza a zárójelek közti
-- String részt. Példa: zarojel "aaa(abc)bb" == "abc"
-- Tipp: használjunk takeWhile, dropWhile-t

zarojel1 :: String -> String
zarojel1 str = takeWhile (\x -> x /= ')') (tail (dropWhile (\x -> x /= '(') str))

-- három függvény kompozíciójaként is megadható
-- emélkezzünk: (f . g) = \x -> f (g x)
zarojel2 :: String -> String
zarojel2 = takeWhile (\x -> x /= ')') . tail . dropWhile (\x -> x /= '(')


-- 3. feladat
-- f1 :: Int -> [Int] -> [Int]
-- vegyük a bemenõ listából minden n-edik elemet
-- pl: f1 2 [0, 1, 2, 3, 4] == [1, 3]
--     f1 1 [0, 1, 2] == [0, 1, 2]
--     f1 3 [0, 1, 2, 3, 4, 5, 6] == [3, 6]

f1 :: Int -> [Int] -> [Int]
f1 n xs | n < length xs = (xs !! (n - 1)) : f1 n (drop n xs)
        | otherwise     = []
