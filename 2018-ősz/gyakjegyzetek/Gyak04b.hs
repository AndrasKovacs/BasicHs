
----------------------------------------

-- curry függvény
curry' :: ((a, b) -> c) -> a -> b -> c
curry' f x y = f (x, y)

  -- megoldás:
  -- 1. soroljunk fel minden paramétert (vagy = bal oldalán, vagy lambdában)
  -- 2. mit tudunk a paraméterek típusáról?
  --      (f :: (a, b) -> c)
  --      (x :: a)
  --      (y :: b)
  -- 3. Mi a cél típus? (A végeredmény típusa)
  --    esetünkben: c
  -- 4. Paraméterek, függvényalkalmazás és egyéb ismert
  --    függvényekkel állítsuk elő a cél típusú kifejezést

  -- Általános esetben ezt a négy lépést érdemes követni.


-- curry-zés: több paraméteres függvény reprezentálása
--   függvényt visszaadó függvénnyel

-- curry' : magasabbrendû függvény, ami elvégzi a curry-zést
-- azaz páron mûködõ függvényt átalakít curry-zett függvénnyé

-- példa: nem curry-zett (+)
add' :: (Int, Int) -> Int
add' (x, y) = x + y

-- curry-zett add:
add :: Int -> Int -> Int
add = curry' add'

-- kiértékelés:
--   add 10 20            -- add definíciója alapján
--   curry' add' 10 20    -- curry' definíciója alapján
--   add' (10, 20)        -- add' definíciója alapján
--   10 + 20              -- (+) mûvelet
--   30

-- Szintén jó gyakorlat:
--   fenti példához hasonlóan végigvezetni egy kifejezés kiértékelését
--   Általános szabály: = bal oldaláról átírjuk a kifejezést a jobb
--   oldalra, illeszkedő minták figyelembevételével.

-- Pl. a (not' True) és a (not' False) tovább értékelhető.

not' :: Bool -> Bool
not' True  = False   -- not' True átírható False-ra
not' False = True    -- ugyanígy


-- uncurry is beépített függvény
uncurry' :: (a -> b -> c) -> (a, b) -> c
uncurry' f (x, y) = f x y

-- egymás utáni curry és uncurry nem csinál lényegében semmit.
add'' :: Int -> Int -> Int
add'' = curry' (uncurry' (curry' add'))


-- több paraméteres curry és uncurry:
-- (curry3    :: ((a, b, c) -> d) -> a -> b -> c -> d)
-- (uncurry3  :: (a -> b -> c -> d) -> ((a, b, c) -> d))
-- (curry4    :: ...)
-- (uncurry4  :: ...)


-- Bevezetõ: rekurzió
------------------------------------------------------------

-- funkc. prog-ban loop helyett általában rekurzív függvényt használunk

-- imperatív loop mindig átírható rekurzív függvényre
-- rekurzív függvény nem mindig írható át loop-ra

-- faktoriális függvény
-- tételezzük fel, hogy az input nem negatív
fact :: Int -> Int
fact 0 = 1    -- azért 1, mivel (*) egységeleme 1
fact n = n * fact (n - 1)

-- rekurzív definíció: arra hivatkozunk a definícióban,
-- amit éppen definiálunk

-- kiértékelés példa:
--  fact 2
--  2 * fact 1
--  2 * 1 * fact 0
--  2 * 1 * 1
--  2

-- fact 3 = 3 * fact 2 = 3 * 2 * fact 1 = 3 * 2 * 1 * fact 0
--        = 3 * 2 * 1 * 1

-- (*) kommutatív, ezért a következő definíció ugyanaz, mint az előző
fact' :: Int -> Int
fact' 0 = 1
fact' n = fact' (n - 1) * n

-- jegyezzük meg, hogy pl. (fact 30) már nem reprezentálható
--  Int-el, és valami rossz eredményre számolódik

-- túlcsordulás: amikor már nem reprezentálható számot
--   kapnánk egy mûvelet eredményeképpen, akkor csak "átfordul"
--   az eredmény

-- Haskell-ben van tetszõlegesen nagy számok típusa: Integer
fact'' :: Integer -> Integer
fact'' 0 = 1
fact'' n = fact'' (n - 1) * n

-- példa: fact'' 1000


-- Rekurzív definícióval fennáll a veszélye, hogy végtelen loop-ot írunk
badFact :: Integer -> Integer
badFact 0 = 1
badFact n = n * badFact n

-- példa: badFact 2
--        2 * badFact 2
--        2 * 2 * badFact 2
--        2 * 2 * ...........

-- ghci-ben loop-ok megszakítása
-- Ctrl-c   vagy   Ctrl-c-c

loop :: Int
loop = loop  -- rekurzív definíció, ahol a loop saját magára
             -- hivatkozik

-- példa: loop = loop = loop = loop ....

-- Listák
------------------------------------------------------------

-- típus: ha "a" egy típus, akkor [a] az
-- az a típusú értékek listája

list1 :: [Int]   -- Int-ek listája
list1 = [0, 1, 2, 3]

list2 :: [Int]
list2 = []

-- [0, 1, 2] jelölés csak rövidítés

-- listák megadása: két alapvetõ módon
-- 1. üres lista
empty :: [Int]
empty = []

-- 2. nemüres (kiegészített lista)
extended :: [Int]
extended = 0 : []             -- ugyanaz, mint [0]
       -- 0 : 1 : []             ugyanaz, mint [0, 1]
       -- 10 : 20 : 30 : []      ugyanaz, mint [10, 20, 30]

-- (:) operátor: kiegészít egy listát egy új elemmel
--     a bal oldalon
-- (:) operátor jobbra zárójelez
--   tehát: (0 : 1 : []) ugyanaz, mint (0 : (1 : []))
--          ami pedig ugyanaz, mint [0, 1]

-- Kérdés: mi (:) és [] típusa?
-- (:) :: a -> [a] -> [a]

-- üres lista bármilyen típusú listának az üres listája
-- [] :: [a]


emptyList1 :: [Int]
emptyList1 = []

emptyList2 :: [Bool]
emptyList2 = []

-- függvények listákon
-- emlékezzünk Bool-ra:
--   két féleképpen lehet Bool-t konstruálni: True, False
--   mintaillesztés Bool-ra: True-ra és False-re


-- listák: két féleképpen adható meg: [] vagy (:)
--         tehát két féle alapvető minta:
isEmpty :: [a] -> Bool
isEmpty []     = True
isEmpty (x:xs) = False
   -- (x:xs) az input lista
   -- x az input elsõ elemére hivatkozik
   -- xs az input lista hátralevõ részére hivatkozik

-- amikor (0 : (1 : []))-re  illesztünk (x:xs)-el
-- x illeszkedi 0-ra
-- xs illeszkedik (1 : [])-re

isEmpty' :: [a] -> Bool
isEmpty' [] = True
isEmpty' _  = False


-- rekurzív függvény: lista hossza
length' :: [a] -> Int
length' []     = 0
length' (x:xs) = 1 + length' xs

-- példa:
--   length' (0:1:[])
--   1 + length' (1:[])
--   1 + 1 + length' []
--   1 + 1 + 0
--   2

-- példa:
--   length' [0,1]
--   1 + length' [1]
--   1 + 1 + length' []
--   1 + 1 + 0
--   2

-- két lista összefûzése:
-- append :: [a] -> [a] -> [a]
-- pl. append [0, 1, 2] [3, 4] == [0, 1, 2, 3, 4]

-- mintaillesztés: elsõ paraméteren
append :: [a] -> [a] -> [a]
append []     ys = ys
append (x:xs) ys = x : append xs ys
                    -- rekurzív hívás

-- példa:
--   append (0:1:[]) (2:3:[])
--   0 : append (1:[]) (2:3:[])
--   0 : 1 : append [] (2:3:[])
--   0 : 1 : (2:3:[])

-- magyarázat, hogy miért az elsõ listán kell mintát
-- illeszteni: azért, mivel a (:) a bal oldalon egészít
--   ki egy listát

-- map: alapból definiálva van
-- ghci-ben példákat

-- példák map-ra : map (\x -> x + 1) [0, 1, 2] == [1, 2, 3]
--                 map not [True, False] == [False, True]
--                 map id  [0, 1, 2] == [0, 1, 2]

map' :: (a -> b) -> [a] -> [b]
map' f []     = []
map' f (x:xs) = f x : map' f xs

-- példa:
--   map' ((+) 1) [0, 1]
--   (0 + 1) : map' ((+) 1) [1]
--   (0 + 1) : (1 + 1) : map' ((+) 1) []
--   (0 + 1) : (1 + 1) : []
--    1      : 2       : []
--   [1, 2]

-- specializáljuk map-et valami konkrét a és b-re
mapSpec :: (Int -> Bool) -> [Int] -> [Bool]
mapSpec = map
