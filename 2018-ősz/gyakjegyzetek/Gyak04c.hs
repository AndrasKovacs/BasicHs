
-- Kovács András (kovacsandras@inf.elte.hu)


-- listák
------------------------------------------------------------

-- típus: ha van tetszőleges "a" típusunk
-- akkor "[a]" az "a" típusú elemek listáinak a típusa

list1 :: [Int]
list1 = [0, 1, 2, 3]

list2 :: [Int]
list2 = []

list3 :: [Bool]
list3 = [True, False, True]

-- Az a jelölés, hogy [1, 2, 3, 4]
--   egy rövidítés listák létrehozására

-- Két alapvető mód van listák konstruálására

-- 1. üres lista: []
-- 2. kiegészített lista:
--    ha van már egy listánk (xs :: [a])
--    és va egy a típusú elemünk (x :: a)
--    akkor a (:) operátorral a lista
--    bal oldalához hozzáadhatjuk az elemet

-- (:) operátor jobbra zárójelez
-- pl: 0 : 1 : []    ugyanaz, mint  0 : (1 : [])

list4 :: [Int]
list4 = 0 : 1 : 2 : 3 : []
     -- röviden: [0, 1, 2, 3]
     -- miden zárójellel: 0 : (1 : (2 : (3 : [])))

-- (:) típusa
-- (:) :: a -> [a] -> [a]

-- [] típusa: [a]
-- [] akármilyen típusú elemek listájához
--    van üres lista

-- nem szeretnénk külön üres listát írni minden
--  különböző elemtípushoz, szeretnénk a csak []-t használni
--  minden esetben

-- emptyIntList :: [Int]
-- emptyBoolList :: [Bool]
-- emptyFunBoolList :: [Bool -> Bool]


-- emlékeztető: Bool-t
--   két féle képpen tudtuk konstruálni: True, False
--   két féle mintát illeszthettünk: True, False

-- általában igaz: ha bizonyos módon tudunk
--   értéket megadni, akkor úgyanezekre tudunk
--   mintát illeszteni


-- mivel lista [] vagy pedig (:), ezekre illeszthetünk mintát
isEmpty :: [a] -> Bool
isEmpty []     = True
isEmpty (x:xs) = False
    -- (x:xs) minta: x hivatkozik a lista első
    --               elemére
    --               xs hivatkozik a lista többi
    --               részére

isEmpty' :: [a] -> Bool
isEmpty' []  = True
isEmpty' _   = False

-- ('-os név: konvenció arra, amikor újradefiniálok valamit)


-- lista hossza:
length' :: [a] -> Int
length' []     = 0
length' (x:xs) = 1 + length' xs

-- (xs, ys, zs, ns: lista típusú változók konvencionális elnevezése)


-- loop-oló definíció
length'' :: [a] -> Int
length'' []     = 0
length'' (x:xs) = 1 + length (x:xs)
   -- length'' (0 :[])
   -- 1 + length'' (0 : [])
   -- 1 + 1 + length'' (0 : [])
   -- 1 + 1 + 1 + 1 + 1 + .....


-- polimorfizmus
------------------------------------------------------------

-- Ha deklarált típusban kisbetűs neveket említünk meg,
-- ezek tetszőleges típusra hivatkoznak

-- Példa motiváció: szeretnénk párok elemeit megcserélni.
-- Mivel végtelen sok pár típus van, nem szeretnénk mindegyikre
-- külön függvényt írni.
swapIntBool :: (Int, Bool) -> (Bool, Int)
swapIntBool (x, y) = (y, x)

swapIntInt :: (Int, Int) -> (Int, Int)
swapIntInt (x, y) = (y, x)

swapFunIntIntFunBoolBool
  :: (Int -> Int, Bool -> Bool)  -- függvények párja
  -> (Bool -> Bool, Int -> Int)  -- függvények párja
swapFunIntIntFunBoolBool (x, y) = (y, x)

-- Polimorf függvény egyszerre definiálható minden típusra:
swap :: (a, b) -> (b, a)
swap (x, y) = (y, x)


-- típus deklarálása nélkül: ghc kikövetkezteti a típust.
-- kikövetkeztetett típus: mindig a legáltalánosabb polimorf típus
swap' (x, y) = (y, x)
-- :t swap' :: (b, a) -> (a, b)

-- nem a legáltalánosabb típus
swap'' :: (a, a) -> (a, a)
swap'' (x, y) = (y, x)


-- néhány alapvető polimorf függvény:

-- identitásfüggvény (alapból id néven)
id' :: a -> a
id' x = x

-- konstans függvény (alapból const néven)
const' :: a -> b -> a
const' x y = x


-- curry-zés: többparaméteres függvények megadásának egy módja
-- nem curry-zett többparaméteres függvények: üggvények tuple inputtal

-- nem curry-zett összeadás:
add :: (Int, Int) -> Int
add (x, y) = x + y
-- alkalmazás: add(10, 20)

-- curry-zett összeadás:
-- függvény nyíl jobbra zárójelez!
add' :: Int -> (Int -> Int)
   --   másképpen: Int -> Int -> Int
add' x y = x + y

-- alkalmazás: add' 10 20
-- függvények alkalmazása balra zárójelez
-- add' 10 20  teljes zárójelezése  (add' 10) 20

add3 :: Int -> Int -> Int -> Int
add3 x y z = x + y + z

-- add3 :: Int -> Int -> Int -> Int
-- add3 10 :: Int -> Int -> Int
-- add3 10 20 :: Int -> Int
-- add3 10 20 30 :: Int

-- add3 :: Int -> (Int -> (Int -> Int))
-- add3 10 :: Int -> (Int -> Int)
-- (add3 10) 20 :: Int -> Int
-- ((add3 10) 20) 30 :: Int


-- ha curry-zett függvényt nem az összes
-- inputra alkalmazzuk: parciális applikáció
-- (ilyenkor függvényt kapunk, ami a hiányzó
--  inputokat várja)
add10 :: Int -> Int
add10 = add' 10

add10' :: Int -> Int
add10' = (+) 10

-- Feladat: definiáljuk az összes (Bool -> Bool) függvényt (4 darab)
f1 :: Bool -> Bool
f1 = id   -- identitás

f2 :: Bool -> Bool
f2 = not  -- negáció

f3 :: Bool -> Bool
f3 = const True

f4 :: Bool -> Bool
f4 = const False

-- ezeket akár listába is tehetjük:
boolFuns :: [Bool -> Bool]
boolFuns = [id, not, const True, const False]


-- függvénykompozíció
-- alapból ghci-ben (.) operátor
-- matematikai jelölés: (f o g)(x) = f(g(x))
compose f g x = f (g x)
   -- találjuk ki compose típusát:

   -- x tetszőleges típusú, legyen x típusa a
   -- ? -> ? -> a -> ?
   -- g input típusa a (mivel x-re alkalmazzuk)
   -- ? -> (a -> ?) -> a -> ?
   -- g outpja legyen b
   -- ? -> (a -> b) -> a -> ?
   -- f inputja b kell hogy legyen
   -- (b -> ?) -> (a -> b) -> a -> ?
   -- f outputja legyen c
   -- (b -> c) -> (a -> b) -> a -> c

-- tehát:
compose :: (b -> c) -> (a -> b) -> a -> c


-- lehetséges feladatok/készségek típusokkal
-- 1: következtesd ki egy definíció általános típusát
-- 2: írj definíciót egy (polimorf) típushoz

-- pl: írj egy definíciót ehhez (de ezt már láttuk: compose)
g1 :: (b -> c) -> (a -> b) -> a -> c
g1 = undefined

-- vagy ehhez:
g2 :: (c -> a -> b) -> (c -> a) -> c -> b
g2 = undefined

-- "type tetris": típusokat követve írni definíciót
