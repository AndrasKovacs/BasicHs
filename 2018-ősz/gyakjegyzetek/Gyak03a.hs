

-- 2. heti házi, példa megoldások
------------------------------------------------------------


f14 :: Bool -> (Int -> Int, Int -> Int)
f14 _ = ((\x -> x), (\x -> x))

f14' :: Bool -> (Int -> Int, Int -> Int)
f14' _ = ((\x -> x + 10), (\x -> x * 10))

f14'' :: Bool -> (Int -> Int, Int -> Int)
f14'' True  = ((\x -> x), (\x -> x))
f14'' False = ((\x -> x + 10), (\x -> x * 10))

f15 :: ((Int -> Int), Int) -> Int
f15 _ = 0

f15' :: ((Int -> Int), Int) -> Int
f15' (f, x) = f x + 100

-- példa alkalmazásra: f15' ((\x -> x * 10) , 100) == 1100
--                     f15  ((\x -> x * 10) , 100) == 0

-- megjegyzés:
-- ghci-ben függvény típusú dolgokat nem tudunk kinyomtatni
--   (egy programban már nem áll rendelkezésre az eredeti
--    függvénydfefiníció)

-- ghci-ben is lehet ugyanúgy definiálni, mint egy fájlban
-- pl: > f = 12312
--     > f
--     > 12312

foo' :: (Int -> Int, Int -> Int)
foo' = f14 True

-- példa foo' használatára:
i1 :: Int
i1 = (fst foo') 100 -- 100
     -- írhattam volna: (fst (f14 True)) 100
     -- eredmény kiszámolása:
     --    f14 True = (\x -> x, \x -> x)
     --    fst(f14 True) = fst (\x -> x, \x -> x)
     --    fst (\x -> x, \x -> x) = \x -> x
     --    (\x -> x) 100 = 100

     -- általános esetben elõfordul: (f x) y
     --   ilyen formájú kifejezés azt jelenti, hogy
     --   (f x) visszaad egy függvényt, amit aztán alkalmazunk
     --   y-ra

-- Curry-zés
------------------------------------------------------------

-- Curry-zés: több paraméteres függvény reprezentálása
--          függvényt visszaadó függvénnyel

-- valójában minden olyan kifejezés, amit eddig
-- "f x y"-nak írtunk, az ugyanaz, mint "(f x) y"

-- példa:
add :: Int -> Int -> Int
add x y = x + y

-- ghci-ben: add 10 2
-- add egy olyan függvény, ami függvényt ad vissza
-- add :: Int -> (Int -> Int)
-- add 0 :: (Int -> Int)
-- add 0 1 :: Int

myFun :: Int -> (Int -> (Int -> Int))
myFun x y z = x + y + z

-- Függvény nyíl (->) jobbra zárójelez,
-- tehát (Int -> Int -> Int) = (Int -> (Int -> Int))

-- függvények alkalmazása pedig balra zárójelez:
-- pl: (add 10) 20 = add 10 20

-- a teljesen zárójelezett alak: (add 10) 20
-- miért: mert (add 10)    :: Int -> Int
--             (add 10) 20 :: Int

-- hosszabb példa:
-- myFun           :: Int -> (Int -> (Int -> Int))
-- myFun 0         :: Int -> (Int -> Int)
-- (myFun 0) 1     :: Int -> Int
-- ((myFun 0) 1) 2 :: Int

-- ghci-ben :t-vel ezzel eljátszhatunk

-- többparaméteres függvénynek, ha kevesebb
-- paramétert adunk, akkor még mindig függvényt kapunk,
-- ami a hiányzó paramétereket várja

-- (myFun 0 1) még egy függvény, ami várja az utolsó inputot
-- ezt még nem lehet ghci-ben kinyomtatni

-- (myFun 0 1 2) már egy Int, tehát ez kinyomtatható

-- nem Curry-zett függvények
-- Haskell-ben olyan függvény, aminek az inputja egy n-es

-- nem Curry-zett myFun:
myFun' :: (Int, Int, Int) -> Int
myFun' (x, y, z) = x + y + z
-- példa: myFun' (0, 1, 2) == 3

-- legtöbb programozási nyelvben
-- a nem-Curry forma az alapértelmezés
-- pl. f(10, 20)

-- mire jó a Curry-zés:

-- egyszerû példák
add10 :: Int -> Int
add10 = add 10
-- régi verziók: add10 x = x + 10
--               add10 = \x -> x + 10

add10' :: Int -> Int
add10' = (+) 10  -- (+) 10 olyan függvény, ami 10-et ad
                 -- egy számhoz

mul10 :: Int -> Int
mul10 = (*) 10  -- 10-el szoroz egy számot
                -- emlékezzünk: (*) :: Int -> Int -> Int
                -- tehát (*) 10 :: Int -> Int

-- további példa: párképzés operátora: (,)
pairZero :: Int -> (Int, Int)
pairZero = (,) 0  -- függvény, ami egy szám elé 0-t párosít
  -- régi definíció: pairZero x = (0, x)
  --                 pairZero = \x -> (0, x)


-- Polimorf függvények
------------------------------------------------------------

-- identitás függvények
idInt :: Int -> Int
idInt x = x

idBool :: Bool -> Bool
idBool x = x

-- végtelen sok típusra lehet id-et írni
-- szeretnénk egyszerre definiálni minden típusra

-- megtehetjük, úgy, hogy kisbetűs típusneveket használunk:
id' :: a -> a  -- azért id', mert már id néven definiálva van alapból
id' x = x

-- típus értelmezése: a -> a
-- legyen a egy tetszõleges típus,
-- és erre van egy (a -> a) függvény

-- példák : id' (True, True) == (True, True)
--          id' 0 == 0
-- függvény bemeneten: id' ((+) 10) 20 == 30
--   zárójelezés: (id' ((+) 10)) 20

-- akárhány tetszõleges típust említhetünk
-- pl. kettõt: tetszõleges típusú pár elemeinek megcserélése
swap :: (a, b) -> (b, a)
swap (x, y) = (y, x)
-- swap (True, 0) == (0,True)
-- swap (0, True) == (True,0)
-- stb. bármilyen a, b típusokra

-- swap-et újradefiniáljuk, de nem deklarálunk típust
swap' (x, y) = (y, x)

-- kikövetkeztetés: mindig a legáltalánosabb típust adja meg

-- :t swap'
-- swap' :: (b, a) -> (a, b)

-- (ez ugyanaz a típus, mint amit mi írtunk, csak máshogy
--  nevezi a,b - t)

-- id típusa szintén általános formában kikövetkeztetve
id'' x = x
-- :t id''
-- id'' :: p -> p

-- haszons gyakorlat: add meg egy kifejezés legáltalánossabb
-- típusát (könnyű csalni ghci-vel, de csalás nélkül tanulságos)

-- konvenció: kis a-tól kezdve nevezzük el a tetszõleges
-- típusokat

-- ghci kikövetkeztetés példák:
-- :t (\x -> x)
-- (\x -> x) :: p -> p
-- :t (\x y -> x)
-- (\x y -> x) :: a -> b -> a
-- :t (\x y z -> y)
-- (\x y z -> y) :: a -> b -> c -> b
