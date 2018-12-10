{-
Próbazh: BEAD-ban eredmények

jegy próbazh-ra:

- elmélet: 12 pontból min 7
- gyak: 19 pont

jegyek:
  16-tól: 2
  19-től: 3
  22-től: 4
  25-től: 5

Tehát, ketteshez:
- min. elméleti ponttal: 9/19 kell szerezni
- max. elméleti ponttal: 4/19 kell szerezni
-}

-- Próbzh, házi pótlás
----------------------------------------
{-
próbzh pótlás:
  - most hét péntek konz időpontban
  - következő héten pótlás
    (első vizsg. időszaki hét)

házi: email-ben küldje akinek hiányzás van

(email-t küldök mindenkinek, akitől várok valamit)
-}

-- Próbazh
----------------------------------------


-- Feladatsorban típus nem volt megadva

-- Hogyan lehet típus nélküli feladatnak minél egyszerűbben típust adni?

-- (ghci-ből tesztesetek alapján kiszedni egy típust)

-- 1. technika:
--   felírunk egy függvényt, aminek a paramétere
--   a cél függvény (amit szeretnénk megírni)
--   és az eredmény pedig egy teszteset (Bool)
--   Lekérdezzük :t-vel a típust
--   Nézzük a kikövetkeztett típus input típusát

try1 head2 =
   (head2 "ab" == ('a','b'))

try2 head2 =
   (head2 [0::Int, 1] == (0, 1))

-- :t try1 = ([Char] -> (Char, Char)) -> Bool
-- paraméter típusa: String -> (Char, Char)

-- :t try2 =
-- (Eq a, Eq b, Num a, Num b) => ([Int] -> (a, b)) -> Bool
-- [Int] -> (a, b)

-- 2. technika: nem írunk típust, csak rögtön definiálunk
--    valamit. Ha megvan a definíció, :t-vel megkapjuk
--    a típust.

--    hátrány: nem kapunk informatív típushibát addig,
--    amíg nincs meg a helyes megoldás.

-- 3. technika: ha alapból tudjuk, hogy mi a feladat típusa


-- 3. eljárás head2-re:
-- head2 [1..10] == (1,2)
-- head2 "ab" == ('a','b')

-- mit látunk: bemenet lista, kimenet pár
--  head2 :: [?] -> (?, ?)
--  két példa: bemenet listák eleme más
--      tehát: tehát tetszőleges elemtípusra működik head2
--  head2 :: [a] -> (a, a)


-- ratAdd (1,2) (1,3) == (5,6)
-- ratAdd (1,1) (1,1) == (2,1)
-- ratAdd (0,2) (1,2) == (2,4)
-- először: két pár bemenet, kimenet pár
--   ratAdd :: (?, ?) -> (?, ?) -> (?, ?)
-- tesztesetekben minden szám, legyen egyszerűség kedvéért
-- Int minden.
--   ratAdd :: (Int, Int) -> (Int, Int) -> (Int, Int)
-- viszont: ha a feladatban törtműveletet kell csinálni,
-- akkor ehelyett vegyük Double-nek a számokat.

-- (törtszámot látunk a példában, akkor nyilván Double)

-- insert 0 1 [] == [1]
-- insert 0 1 [2,3] == [1,2,3]
-- insert 1 'x' "abc" == "axbc"
-- insert 3 'x' "abc" == "abcx"
--   három input, a harmadik mindig lista
--     az első mindig szám
--     insert :: Int -> ? -> [?] -> [?]
--   második input ugyanolyan típusú, mint a listaelemek
--     insert :: Int -> a -> [a] -> [a]

-- (szerintem vizsgafeladatban nemkell kitalálni
--  (Eq a) vagy (Ord a) jellegű dolgot)
-- (próbazh-ban stílushiba)
-- minimumOfMaxima :: Ord a => [[a]] -> a


-- Eq, Ord megszorítások
----------------------------------------

-- típusdeklaráció: lehet az elején => előtt
-- felsorolhatunk megszorításokat.

-- megszorítjuk a-típust csak az olyan típusokra,
-- amire van (==) művelet.
g1 :: (Eq a) => a -> a -> Bool
g1 x y = (x == y)

-- lehet több megszorítás is, akárhány típusváltozóra
-- Ord a : van összehasonlítás a-ra.
-- (több megszorítás esetén zárójelben a => előtti rész)
f2 :: (Eq a, Ord a) => a -> a -> Bool
f2 x y = if x < y then y == y else False

-- mivel találkoztunk: Eq, Ord, Show
-- Eq: egyenlőség, Ord: összehasonlítás,
-- Show: String-é alakítás, ahhoz kell, hogy ghci-ven
--       értékeket tudjunk megjeleníteni


-- próbazh megoldások
----------------------------------------

f1 :: Int -> Bool
f1 x = (mod x 2 == 0) || (mod x 3 == 0) || (mod x 5 == 0)

-- divides x y = mod x y == 0
-- f1 x = divides x 2 || divides x 3 || divides x 5

head2 :: [a] -> (a, a)
head2 (x:y:_) = (x, y)  -- (csak a 2+ elemű lista érdekes)

-- head2 [1..10] == (1,2)
-- head2 "ab" == ('a','b')

ratAdd :: (Int, Int) -> (Int, Int) -> (Int, Int)
ratAdd (a, b) (c, d) = (a * d + c * b, b * d)
-- (mivel példában nincs egyszerűsítve az eredmény,
--  ezért mi sem foglalkozunk ezzel)

fac :: Int -> Int
fac n | n <= 1    = 1
      | otherwise = n * fac (n - 1)

-- fac n = if n <= 1 then 1 else n * fac (n - 1)

-- (mivel feladat azt mondta, hogy "1-re vagy
-- kisebb számokra", ezért összehasonlítást
-- biztosan csinálni kell)

-- (csaló megoldás, de ezt biztosan elfogadom)
-- minimumInt :: [Int] -> Int
-- minimumInt = minimum

-- (lista nem üres: nincs [] minta)
minimumInt :: [Int] -> Int
minimumInt [x]   = x
minimumInt (x:xs)= min x (minimumInt xs)
-- min x y = if x < y then x else y


-- insert 0 1 [] == [1]
-- insert 0 1 [2,3] == [1,2,3]
-- insert 1 'x' "abc" == "axbc"
-- insert 3 'x' "abc" == "abcx"

insert :: Int -> a -> [a] -> [a]
insert 0 x xs     = x:xs    -- lista elejére szúrunk
insert n x (y:xs) = y: insert (n - 1) x xs
                  -- lista tail-részébe szúrunk

-- standard fv. megoldás:
-- insert n x xs = take n xs ++ [x] ++ drop n xs

dropUntil :: (a -> Bool) -> [a] -> [a]
dropUntil f []    = []
dropUntil f (x:xs) | f x       = (x:xs)
                   | otherwise = dropUntil f xs

-- standard definíció
dropUntil' f xs = dropWhile (\x -> not (f x)) xs

-- minimumOfMaxima [[3,4,5],[1,2,3],[7,8,9]] == 3
-- minimumOfMaxima [[4,7],[1,2,9],[5]] == 5
-- minimumOfMaxima [[9],[8],[1]] == 1
-- minimumOfMaxima ["hello", "haskell", "world"] == 'o'

-- (minden lista nemüres)
minimumOfMaxima :: Ord a => [[a]] -> a
minimumOfMaxima [xs]     = maximum xs
minimumOfMaxima (xs:xss) =
  min (maximum xs) (minimumOfMaxima xss)

-- min és maximum újradefiniálható

-- std megoldás:
minimumOfMaxima' xss = minimum (map maximum xss)
-- minimumOfMaxima' = minimum . map maximum

safeHead :: [a] -> Maybe a
safeHead (x:_) = Just x
safeHead []    = Nothing

-- (látjuk azt, hogy safeHead nem túl nehéz, tehát
--  korábbi feladatokat tessék átugrani, és először
--  a legkönnyebb feladatokat megoldani)


-- minden hossz Double
data Shape = Circle Double | Rectangle Double Double
           | Triangle Double Double
           deriving (Eq, Show)

scale :: Double -> Shape -> Shape
scale x (Circle r)      = Circle (x * r)
scale x (Rectangle h w) = Rectangle (x*h) (x*w)
scale x (Triangle h b)  = Triangle (x*h) (x*b)

area :: Shape -> Double
area (Circle r)      = r * r * pi
area (Rectangle h w) = h * w
area (Triangle h b)  = (h * b) / 2
