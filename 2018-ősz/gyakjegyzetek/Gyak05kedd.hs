

-- Lambda függvények
------------------------------------------------------------

-- matematikai jelölés függvényre
--    x ↦ x + x
-- (x-hez rendeljük hozzá x + x -et)

f1 :: Int -> Int
f1 = (\x -> x + x)

-- f1-et definiáljuk egy függvénnyel
-- (\x -> ...) az egy olyan kifejezés ami egy függvényt megad hozzárendeléssel

-- általában: (->) erõssebben zárójelez, mint a (,)
-- Függvények párja:
f2 :: ((Int -> Int), (Int -> Int))
f2 = ((\x -> x + 1) , (\x -> x))
             -- rögtön megadok két függvényt
             -- anélkül, hogy korábban névvel
             -- definiáltam volna

f2' :: (Int -> Int, Int -> Int)
f2' = ((\x -> x + 1) , id)

-- vesszük f2 elsõ elemét, ami egy függvény
-- ismétlés: fst veszi egy pár elsõ elemét
--           snd a második elemét

-- fst :: (a, b) -> a
-- snd :: (a, b) -> b
g :: Int -> Int
g = fst f2

-- példa kiértékelés:
--  fst f2 100
--  (fst f2) 100
--  (fst (((\x -> x + 1) , (\x -> x)))) 100
--  (\x -> x + 1) 100
--  101

-- lambda kifejezések :
-- (\x -> x * x)     ("\" kiejtése: lambda)

-- Miért van ez a feature?
-- Nem akarunk nevesített függvényeket egyszeri használatra definiálni.

-- lambdás verzió:
list1 :: [Int]
list1 = map (\x -> x * x) [10, 20, 30, 40]

-- lambda nélküli:
fun :: Int -> Int
fun x = x * x

list1' :: [Int]
list1' = map fun [10, 20, 30, 40]

-- név nélkül, közvetlenül definiálunk függvényt
-- (lambda függvényt néha úgy is hívják: anonim függvény)

-- (bónusz:
--  Csak lambda kifejezésekkel (név szerinti rekurzív hívás nélkül)
--  lehet-e rekurzív függvényt írni? Lehet. Utánanézni opcionálisan:
--  Y-kombinátor, fixpont kombinátorok)

-- többparaméteres lambda:
fun2' :: Int -> Int -> Int
fun2' = (\x y -> x + y + 1)

-- (a fenti csak rövidítés arra, hogy egymás után több
--  lambdát írunk)
fun2'' :: Int -> Int -> Int
fun2'' = (\x -> \y -> x + y + 1)
   -- zárójelezés: (\x -> (\y -> x + y + 1))

-- valójában az alábbi is az egymásba ágyazott
-- lambda definíció rövidítése
fun2''' :: Int -> Int -> Int
fun2''' x y = x + y + 1
-- fun2'' = (\x -> (\y -> x + y + 1))


-- Case kifejezés
------------------------------------------------------------

-- case kifejezés: akárhol illeszthetünk kifejezésre mintát

-- ha új sorba írjuk a mintákat, akkor a mintákat jobban be kell húzni,
-- mint a "case"-et, és egy oszlopba kell őket húzni.
-- Minták jelölése ugyanaz, mint a függvényparamétereknél.
not' :: Bool -> Bool
not' x = case x of
  True  -> False
  False -> True

-- írhatjuk egy sorba is a mintákat, ekkor ";"-vel kell őket elválasztani
not'' :: Bool -> Bool
not'' x = case x of True -> False; _ -> True

-- példák case-re valamilyen részkifejezésben
case1 :: Int -> Int
case1 x = 100 + (case x of 0 -> 1000; _ -> 10000)

case2 :: Int -> (Int, Int)
case2 x = (100, case x of 10 -> 1; 20 -> 2; _ -> 100)
-- case2 0 == (100, 100)


-- Rekurzív listafüggvények
------------------------------------------------------------

-- (definíció rejtése a következő módon, pl. "drop" és "take" függvényt)
-- import Prelude hiding (drop, take)

-- két lista összefûzése
append :: [a] -> [a] -> [a]
append []     ys = ys
append (x:xs) ys = x : append xs ys
   -- Eredmény sorban x-et, xs elemeit, aztán ys elemeit tartalmazza.
   -- Első paraméter csökken minden rekurzív hívással.

-- standard (++) operátor: ugyanaz mint a fenti append definíció

-- Rekurzív függvényre általában: legalább egy paraméter "csökkenjen"
-- minden rekurzív híváskor: közelíteni kell olyan esethez, amikor
-- nincs több rekurzív hívás ("base case").


-- drop :: Int -> [a] -> [a]
-- hagyjuk el az elsõ n elemet egy listából.

-- Az alábbi egy olyan definíció, ami negatív Int-re mindig üres listát ad.
drop' :: Int -> [a] -> [a]
drop' n []     = []
drop' 0 xs     = xs
drop' n (x:xs) = drop' (n - 1) xs

-- Standard drop: negatív Int-re visszaadja az input listát.
drop'' :: Int -> [a] -> [a]
drop'' n xs | n <= 0 = xs
drop'' n [] = []    -- üres listából nem tudunk semmit
                    -- elhagyni
drop'' n (x:xs) = drop'' (n - 1) xs
   -- az egész listából úgy tudunk n elemet elhagyni
   -- hogy a lista hátralevõ részébõl (n-1)-et hagyunk
   -- el


-- take :: Int -> [a] -> [a]
-- vegyük az elsõ n-elemet tartalmazó listát egy listából
take' :: Int -> [a] -> [a]
take' n xs | n <= 0 = []
take' n [] = []
take' n (x:xs) = x : take' (n - 1) xs


-- map :: (a -> b) -> [a] -> [b]
-- az input lista minden elemére alkalmazzuk az input függvényt
-- példák : map (\x -> x + 10) [0, 1, 2] == [10, 11, 12]
--          map id [0, 1, 2] == [0, 1, 2]
--          map (const True) [0, 1, 2] == [True, True, True]

map' :: (a -> b) -> [a] -> [b]
map' f []     = []
map' f (x:xs) = f x : map' f xs

-- kiértékelés példa:
--  map ((+) 10) [0, 1]
--  (+) 10 0 : map ((+) 10) [1]
--  (+) 10 0 : (+) 10 1 : map ((+) 10) []
--  (+) 10 0 : (+) 10 1 : []
--  10 : 11 : []
--  [10, 11]

-- ha egy függvénynek nem értjük a mûködését
-- érdemes végigvezetni egy kifejezés kiértékelését

-- filter :: (a -> Bool) -> [a] -> [a]
-- egy listban tartsuk meg az olyan elemeket
-- amelyekre igaz egy (a -> Bool) feltétel

filter' :: (a -> Bool) -> [a] -> [a]
filter' f []     = []
filter' f (x:xs) | f x       = x : filter' f xs
                 | otherwise = filter' f xs


--  filter id [True, True, False] == [True, True]
--  filter not [True, True, False] == [False]
--  filter (\x -> x < 10) [8, 9, 10, 11] == [8, 9]
