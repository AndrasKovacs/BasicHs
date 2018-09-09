{-# options_ghc -fwarn-incomplete-patterns #-}

-- Írjunk egy listát, ami az 1000-nél nagyobb négyzetszámokat
-- tartalmazza!

nums :: [Integer]
nums = [x^2 | x <- [0..], x^2 > 1000]

-- Rekurzív listafüggvények + mintaillesztés
---------------------------------------------

-- 1. függvény definíció
f :: Int -> Int
f n = n

f2 :: Int -> Int -> Int
f2 n m = n + m

-- alternatív : lambda kifejezés (név nélküli függvény)

f' :: Int -> Int
f' = (\n -> n)    --  zárójel elhagyható: \n -> n

f2' :: Int -> Int -> Int
f2' = \n m -> n + m
   --  n ↦ n

-- mintaillesztés számokra (több soros definíció)
-- füntről lefelé vizsgáljuk, hogy illeszkedik-e
-- a minta az = bal oldalán, ha illeszkedést
-- találunk, akkor visszaadjuk a = jobb oldalát
h :: Int -> Int
h 0 = 10
h n = 100

h' :: Int -> Int
h' n = if n == 0 then 10 else 100

-- listáknál: minta: üres lista vagy nemüres lista

-- egyszeresen láncolt lista a std. lista
-- valójában a lista literál az szintaktikus cukor

list1 :: [Int]
list1 = [1, 2, 3]  -- cukor

list1' :: [Int]
list1' = 1 : (2 : (3 : []))  -- : operátor: lista elé fűzés
      -- 1 : 2 : 3 : []      -- ":" kiejtése: cons

list2 :: [Int]
list2 = [10]

list2' :: [Int]
list2' = 10 : []

-- listára mintaillesztés: üres/nemüres
drop' :: Int -> [Int] -> [Int]
drop' 0 xs     = xs
drop' n []     = []
drop' n (x:xs) = drop' (n - 1) xs
  -- itt : x változó hivatkozik a lista első elemére
  --       xs változó hivatkozik a lista hátralevő részére

take' :: Int -> [Int] -> [Int]
take' 0 xs     = []
take' n []     = []
take' n (x:xs) = x : take' (n - 1) xs

append :: [Int] -> [Int] -> [Int]
append []     ys = ys
append (x:xs) ys = x : append xs ys

-- rossz definíció (loop)
append' :: [Int] -> [Int] -> [Int]
append' xs []     = xs
append' xs (y:ys) = append' (append' xs [y]) ys

-- loop: ugyanazzal az argumentummal hívunk rekurzívan
-- mint amit megkapunk
-- append' xs [y] = append' (append' xs [y]) [y]

-- loop-ot tudunk

-- új dolog: minta belsejében újabb minta: (x:[])
init' :: [Int] -> [Int]
init' []     = []           -- üres
init' (x:[]) = []           -- 1 elemű
init' (x:xs) = x : init' xs -- 2 + n elemű

-- -- mintáknál működik a lista szintaktikus cukor is
-- foo :: [Int] -> Int
-- foo [] = 0
-- foo (0:xs) = 3030
-- foo [0, 1, 2] = 35354 -- redundáns minta: soha nem illeszkedik
-- foo (0:1:2:xs) = 353453

foo' :: [Int] -> Int
foo' (x:xs) = 100   -- hiányos mintaillesztés (kerüljük)
                    -- kapcsoljuk be: -fwarn-incomplete-patterns
-- warning eltűnik, ha ezt ohzzáadjuk: foo' [] = 3
foo' [] = 0

-- polimorf függvények (bevezetés)
----------------------------------------

-- akármilyen listára, ne csak Int listára írjuk meg
-- hasonló ahhoz: C++ template (generikus) definíció
-- Haskell-ban a technikai megnevezés: polimorf függvény
-- Haskell terminológia jóval régebbi, mint a C++

drop'' :: Int -> [a] -> [a]
drop'' 0 xs     = xs
drop'' n []     = []
drop'' n (x:xs) = drop'' (n - 1) xs

append'' :: [a] -> [a] -> [a]
append'' []     ys = ys
append'' (x:xs) ys = x : append'' xs ys

-- típus annotáció: nem kötelező, de jó gyakorlat kiírni

zip' :: [a] -> [b] -> [(a, b)]
zip' (a:as) (b:bs) = (a, b) : zip' as bs
zip' as     bs     = []

-- default elemmel kiegészíteni a rövidebb listát
-- zip'' :: a -> b -> [a] -> [b] -> [(a, b)]

-- concat (példa: concat [[1, 2, 3], [4, 5]] == [1, 2, 3, 4, 5])
concat' :: [[a]] -> [a]
concat' []       = []
concat' (xs:xss) = xs ++ concat' xss

-- intuitív: concat [a, b, c, d] == a ++ b ++ c ++ d ++ []

-- interleave: összefésülés
-- példa: interleave [0, 1, 2] [3, 4, 5] == [0, 3, 1, 4, 2, 5]

-- első definíció
interleave :: [a] -> [a] -> [a]
interleave (x:xs) (y:ys) = x : y : interleave xs ys
interleave []     ys     = ys
interleave xs     []     = xs

-- másik definíció
interleave' :: [a] -> [a] -> [a]
interleave' (x:xs) ys = x : interleave' ys xs
interleave' []     ys = ys

-- egyszerű standard polimorf függvények

-- identitásfüggvény
id' :: a -> a
id' x = x

-- lambda kifejezés nélkül kényelmetlen:
-- add10 :: Int -> Int
-- add10 x = x + 10

-- myList :: [Int]
-- myList = map add10 [0..10]

myList :: [Int]
myList = map (\x -> x + 10) [0..10]

myList' :: [Int]
myList' = [x + 10 | x <- [0..10]]
   -- lista kifejezés: szintaktikus cukorka
   -- hogy minek a cukorkája, azt nem áruljuk el

-- map implementációja

-- mi a map' típusa?
map' :: (a -> b) -> [a] -> [b]
map' f []     = []
map' f (x:xs) = f x : map' f xs

--
