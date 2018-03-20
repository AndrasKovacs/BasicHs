-- Magasabbrendű lista függvények (folyt.)
-------------------------------------------

map' :: (a -> b) -> [a] -> [b]
map' f []     = []
map' f (x:xs) = f x : map' f xs

-- jegyzet: "hajtogatások"
----------------------------------------

-- "fold right" (nem teljesen jó név, de
--  valamit mond)
foldr' :: (a -> b -> b) -> b -> [a] -> b
foldr' f b []     = b
foldr' f b (a:as) = f a (foldr' f b as)

-- f legyen (+)
-- b legyen 0
-- második sor:
--   foldr' (+) 0 (a:as) = (+) a (foldr' (+) 0 as)
--                       = a + foldr' (+) 0 as


-- sum (0:1:2:[]) == 0 + (1 + (2 + 0))
sum' :: [Int] -> Int
sum' = foldr' (+) 0  -- üres listát 0-ra cseréljük
                     -- :-ot pedig (+)-re cseréljük
                     -- (0:1:[]) == 0 + (1 + 0)

-- általános működés
-- foldr' f b (a1:a2:a3:[]) == f a1 (f a2 (f a3 b))

-- foldr'-el nagyon sok függény felírható
--   sok trükkös feladat: defináljuk X-et újra
--   foldr' alkalmazásával

-- append' (x:y:[]      ) (a:b:[]) == (x:y:a:b:[])
--         (x:y:(a:b:[]))

append' :: [a] -> [a] -> [a]
append' xs ys = foldr' (:) ys xs

product' :: [Int] -> Int
product' = foldr' (*) 1

-- map' f (a   : b   : c   : []) =
--        (f a : f b : f c : [])

map'' :: (a -> b) -> [a] -> [b]
map'' f as = foldr (\a bs -> f a : bs) [] as

-- map' f (a   : b   : c   : []) =
--        (f a : f b : f c : [])

-- map' f (a : []) = (\a bs -> f a : bs) a []
--                 = f a : []

-- egyenlőségek szerinti kifejtés ("levezetés")
--    f exp

-- vég-rekurzív
foldl' :: (b -> a -> b) -> b -> [a] -> b
foldl' f b []     = b
foldl' f b (a:as) = foldl' f (f b a) as

-- nem vég-rekurzív
sumBad :: [Int] -> Int
sumBad []     = 0
sumBad (x:xs) = x + sumBad xs

-- akkumulátoros
sumGood :: Int -> [Int] -> Int
sumGood acc []     = acc
sumGood acc (x:xs) = sumGood (acc + x) xs

sumGood' :: [Int] -> Int
sumGood' = sumGood 0

-- foldl működése általánosan:
-- foldl f jóska (a : b : c : [])
--   = f (f (f jóska a) b) c

sum3 :: [Int] -> Int
sum3 = foldl' (+) 0

product2 :: [Int] -> Int
product2 = foldl' (*) 1

-- sum'' (a : b : c : []) = ((0 + a) + b) + c

-- Újradefiniálni dolgokat foldl-el
----------------------------------------

-- foldl nélkül
reverse' :: [a] -> [a] -> [a]
reverse' acc []     = acc
reverse' acc (a:as) = reverse' (a:acc) as

reverse'' :: [a] -> [a]
reverse'' = reverse' []

-- levezetés:
--   reverse' [] (a:b:c:[])
-- = reverse' (a:[]) (b:c:[])
-- = reverse' (b:a:[]) (c:[])
-- = reverse' (c:b:a:[]) []
-- = (c:b:a:[])

-- foldl-el

reverse2 :: [a] -> [a]
reverse2 as = foldl' (\as a -> a : as) [] as

-- összefoglalás: foldl értelmezése:
-- foldl f b xs : akkumulátoros feldolgozás,
-- ahol "b" a kezdő akkumulátor érték
-- és "f" az akkumulátort frissítő függvény

-- kód golfozás: (code golfing) valamilyen problémát
-- minél kevesebb karakterből megoldani

flip' :: (a -> b -> c) -> b -> a -> c
flip' f b a = f a b

reverse2' :: [a] -> [a]
reverse2' = foldl' (flip (:)) []
  -- parciális applikáció miatt:
  -- mindig meg tudjuk csinálni, hogy
  --   f x = expression x
  --   f = expression
  -- (transzformáció neve: éta-redukció)

  -- másik transzformáció:
  --   (\as a -> a : as) =
  --   (\as a -> (:) a as) =
  --   (flip (:))

  -- opcionálisan: fejtsük ki a (flip (:))-ot
  -- definíció szerint

-- add10 :: Int -> Int
-- add10 x = 10 + x
--     -- (+) 10 x

-- add10 :: Int -> Int
-- add10 = (+) 10

and' :: [Bool] -> Bool
and' = foldr' (&&) True

-- (Extra anyag: miért pont a True?)

-- szeretnénk hogy igaz legyen:
--     sum (xs ++ ys) = sum xs + sum ys
--     diszktrét mat terminológia:
--     (azt szeretnénk, hogy sum homomorfizmus legyen)

-- szükséges: sum [] = 0
-- sum ([] ++ xs) = sum [] + sum xs

-- szorzásnál:
-- azt szeretnénk, hogy:
--   product (xs ++ ys) = product xs * product ys
-- tehát: szükséges, hogy (product [] = 1)
-- röviden: a szorzás identitáseleméhez
--          az összefűzés identitáselemét rendeljük

-- a logikai (&&) identititáseleme a True
--    (∀ x . (True && x = x))

-- tehát: az összefűzés identitáseleméhez (ami az [])
-- a True-t rendeljük

or' :: [Bool] -> Bool
or' = foldr (||) False

-- and'/or' függvényeket definiálunk, akkor
-- foldl-t vagy foldr-t használjunk?
----------------------------------------

-- or' = foldl' (||) False
-- végtelen listákon a foldr definíciók működhetnek
-- a foldl viszont mindig loop-ol

-- példa : foldr (&&) True ([False] ++ repeat True)
--           = False
--         foldr (||) False ([True] ++ repeat False)
--           = True

-- igazat ad, hogyha legalább egy értékre igazat
-- ad az (a -> Bool) függvény

-- any' :: (a -> Bool) -> [a] -> Bool
-- any' f []     = False
-- any' f (a:as) = f a || any' f as

any' :: (a -> Bool) -> [a] -> Bool
any' f as = foldr (\a b -> f a || b) False as

any'' :: (a -> Bool) -> [a] -> Bool
any'' f as = or' (map f as)
-- golfos verzió: any'' f = or' . map f

-- vizsgáljuk, hogy egy érték a listában van
elem' :: Eq a => a -> [a] -> Bool
elem' a = any'' (\a' -> a == a')
-- any'' (\a' -> a == a) :
-- létezik-e olyan a' a listában, hogy "a == a'"?

-- (extra anyag: fibonacci sorozat definíciója)

-- fibonacci sorozat végtelen listában
-- extra házi: meditáljunk az alábbi definíción
fibs :: [Integer]
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)
