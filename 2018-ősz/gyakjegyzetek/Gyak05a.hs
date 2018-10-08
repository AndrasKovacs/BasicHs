
-- 2. házi feladat
------------------------------------------------------------

-- Fölösleges alkalmazások pl:

-- if True then x else y == x
-- (x == True) == x

-- fst (x, y) == x
-- fst (fst ((x, y), z)) == x

-- (zárójelben: ha ghc-vel lefordítjuk a programot,
--  ezek a felesleges elemek mind eltűnnek)


-- Listák, rekurzió
------------------------------------------------------------

-- ismételés: length
length' :: [a] -> Int
length' []     = 0
length' (x:xs) = 1 + length' xs

-- sum: Int lista elemeinek az összege
sum' :: [Int] -> Int
sum' []     = 0
sum' (x:xs) = x + sum' xs

-- sum' [10, 20] = 10 + sum' [20] =
-- 10 + 20 + sum' [] = 10 + 20 + 0 = 30

-- sum' (10:20:[]) = 10 + sum' (20:[]) =
-- 10 + 20 + sum' [] = 10 + 20 + 0 = 30

-- listák összefûzése:
-- standard neve: (++) operátor
-- pl: [0, 1, 2] ++ [3, 4] == [0, 1, 2, 3, 4]

append :: [a] -> [a] -> [a]
append []     ys = ys
append (x:xs) ys = x : append xs ys
  -- végeredmény: x, utána xs elemei, utána ys elemei

-- append [0, 1] [2]
-- 0 : append [1] [2]
-- 0 : 1 : append [] [2]
-- 0 : 1 : [2]
-- 0 : 1 : 2 : []
-- [0, 1, 2]

-- standard: (++)

-- take: veszi az elsõ n elemet tartalmazó listát
--         egy listából
-- pl: take 2 [0, 1, 2] == [0, 1]
-- (take standard)

-- elsõ definíció: feltételezzük, hogy az Int
-- paraméter nem negatív
take' :: Int -> [a] -> [a]
take' 0 xs     = []  -- vegyük az elsõ 0 darab elemet: []
take' n []     = []  -- még vennénk elemet, de már nincs
take' n (x:xs) = x : take' (n - 1) xs
          -- vennénk le elemet, és van is a listában
          -- tehát levesszük x-et, és rekurzívan
          -- veszünk (n-1) elemet a lista többi részébõl

-- take 1 [] = []
-- take 0 [1, 2] = []
-- take 1 [1, 2] = 1 : take (1 - 1) [2]
-- = 1 : take 0 [2] = 1 : []
-- = [1]

-- take verziója, ahol lehet negatív az Int

-- (Int-ek összehasonlítása):
--   Számok összehasonlítása:
--   operátorok: (<), (<=), (>), (>=)
--   minden ilyen operátor Bool-t ad vissza
--   többféle típuson is alkalmazhatunk összehasonlítást
--   mûködik: Int-re, Double-re, Bool-ra
--   (Bool-ra: False kisebb mint True)
--   csak ugyanolyan típusú dolgokat lehet összehasonlítani

--   működik listákon is, feltéve ha a listaelemek összehasonlíthatók
--   ((==) is működik listákon, ha van (==) a listaelemekhez)


take'' :: Int -> [a] -> [a]
take'' n xs =
  if (n <= 0)
    then [] -- nem veszünk egy elemet sem
    else case xs of
      []   -> [] -- nem tudunk venni elemet
      x:xs -> x : take'' (n - 1) xs

    -- zárójelezés: a case kifejezés egyetlen
    -- kifejezés:
    -- else (case xs of
    --   []   -> []
    --   x:xs -> x : take'' (n - 1) xs)

    -- emlékeztetõ: case bárhol használható
    -- pl: 10 * (case True of True -> 20; False -> 30)

    -- (ha egy sorban is írhatjuk a case mintákat,
    --  de akkor pontosvesszõvel válasszük el õket)

    -- pl: (case x of True -> y; False -> z)

    -- pontosvesszõ nélkül:
    -- case x of
    --   True -> y
    --   False -> z

-- harmadik definíció: õrfeltétel (angol: guard)
-- akármilyen minta után: "| feltétel = ... "
-- a feltétel egy Bool típusú kifejezés
-- akkor ez a minta csak akkor illeszkedik, ha a feltétel True

take''' :: Int -> [a] -> [a]
take''' n xs | n <= 0 = []
take''' n []          = []
take''' n (x:xs)      = x : take''' (n - 1) xs

-- (egyenlõségjelek/paraméterek egy oszlopba húzása: ízlés kérdése)


-- drop: elsõ n elem elhagyása egy listáról
-- (standard)
-- pl: drop 2 [0, 1, 2, 3] == [2, 3]
--     drop 0 xs == xs

drop' :: Int -> [a] -> [a]
drop' n xs | n < 1 = xs
drop' n []         = []
drop' n (x:xs)     = drop' (n - 1) xs

-- otherwise csak egy definíció, ami úgy van megadva,
-- hogy otherwise = True
drop'' :: Int -> [a] -> [a]
drop'' n []                 = []
drop'' n (x:xs) | n <= 0    = x:xs
                | otherwise = drop'' (n - 1) xs
-- alternatív:
-- drop'' n (x:xs) =
--   if n <= 0
--     then x:xs
--     else drop'' (n - 1) xs


------------------------------------------------------------

-- map :: (a -> b) -> [a] -> [b]
-- lista minden elemére alkalmazzunk egy függvényt

-- pl: map (\x -> x + 10) [0, 1, 2, 3, 4] == [10,11,12,13,14]
--     map id [0, 1, 2, 3] == [id 0, id 1, id 2, id 3]
--                         == [0, 1, 2, 3]

-- (függvényen nincs mintaillesztés)
map' :: (a -> b) -> [a] -> [b]
map' f []     = []
map' f (x:xs) = f x : map' f xs

-- kiértékelés: map ((+) 10) [0, 1]
--           = (+) 10 0 : map ((+) 10) [1]
--           = (+) 10 0 : (+) 10 1 : map ((+) 10) []
--           = (+) 10 0 : (+) 10 1 : []
--           = 10 : 11 : []
--           = [10, 11]


-- filter :: (a -> Bool) -> [a] -> [a]
-- adjunk vissza olyan listát, amiben csak azokat
-- az elemeket hagyjuk, amire igaz egy feltétel
filter' :: (a -> Bool) -> [a] -> [a]
filter' f []     = []
filter' f (x:xs) | f x       = x : filter' f xs
                 | otherwise = filter' f xs

-- pl : filter ((==) 0) [2, 2, 0, 0, 1] == [0, 0]
--      filter (\x -> x < 10) [7, 8, 9, 10, 11]
