

-- Függvények megjelenítése ghci-ben
------------------------------------------------------------

-- Függvény típusú értéket nem tudunk kinyomtatni ghci-ben.
-- Azért nem, mivel a program futása során a függvények eredeti
-- definíciója nincs követve.


-- Curry-zés, polimorf függvény (gyakorlás)
------------------------------------------------------------

-- Curry-zés:
-- többparaméteres függvény: lehet Curry-zett,
--                           vagy pedig nem Curry-zett

-- Curry-zés: módszer többparaméteres fv. reprezentálására

-- nem Curry-zett több paraméteres függvények:
f1 :: (Int, Int) -> Int
f1 (x, y) = x + y

-- Curry-zett: függvényt adunk vissza
f1' :: Int -> (Int -> Int)
f1' = \x y -> x + y
-- f1' x y = x + y

f2 :: Int -> Int -> Int -> Int
-- a (->) jobbra zárójelez
-- tehát: Int -> (Int -> (Int -> Int))
--  függvényt visszaadó függvény
f2 x y z = x + y + z

-- praktikus szemszögbõl:
-- Curry-zett függvény: kevesebb inputra is alkalmazható,
-- és akkor olyan függvényt kapunk, ami a hiányzó inputokat
-- várja

-- parciális applikáció: Curry-zett függvény alkalmazása nem az összes inputra.

f3 :: Int -> Int -> Int
f3 = f2 0

-- > :t f2
-- f2 :: Int -> Int -> Int -> Int
-- > :t f2 0
-- f2 0 :: Int -> Int -> Int
-- > :t f2 0 1
-- f2 0 1 :: Int -> Int
-- > :t f2 0 1 2
-- f2 0 1 2 :: Int

-- emlékeztetõ: ha egy operátort bezárójelezünk,
-- akkor az függvénynévként viselkedik

-- elõny: új függvényeket gyakran kényelmes úgy megadni,
-- hogy korábban definiált függvényeket alkalmazunk
-- nem az összes inputon
add10 :: Int -> Int
add10 = (+) 10

mul10 :: Int -> Int
mul10 = (*) 10

-- kicsit trükkösebb példa
-- a párképzés operátor (,) is csak egy függvény!
-- :t (,)
-- (,) :: a -> b -> (a, b)

pair0 :: Int -> (Int, Int)
pair0 = (,) 0
-- (,) :: Int -> Int -> (Int, Int)
-- (,) 0 :: Int -> (Int, Int)
-- példák: pair0 10 == (0, 10)
--         pair0 20 == (0, 20)
--         stb..


-- 0 mögé párosítása
pair0' :: Int -> (Int, Int)
pair0' = \x -> (x, 0)  -- mögé párosítás

-- ezt a függvényt parciális applikációval nem tudjuk
-- megadni, mert csak az elsõ N darab paramétert tudjuk
--  pariálisan megadni, és nem pedig mondjuk csak a második
--  paramétert.

-- tehát érdemes az alkalmazás során kevésbé változó
-- paramétereket elõre hozni

-- egyszerû (mesterséges) példa:
addMul :: Bool -> Int -> Int -> Int
addMul True  = (+)
addMul False = (*)

-- régi definíció:
-- addMul True  x y = x + y
-- addMul False x y = x * y

add' = addMul True
mul' = addMul False

-- add' 10 10 == 20
-- mul' 10 10 == 100

-- lambda vs. paraméteres definíció:

f4 :: Int -> Int -> Int
f4 x y = x + y

f4' :: Int -> Int -> Int
f4' = (\x y -> x + y)
-- többparaméteres lambda kifejezés:
--  \x y -> x + y
--  ez annak a rövidítése, hogy:
--  \x -> (\y -> x + y)

-- Egy többparaméteres függvény definiálásánál mindig van lehetőség, hogy
-- kevesebb paramétert vezessünk be az = bal oldalán. Ilyen esetben
-- az = jobb oldalán függvény tíusú kifejezést kell megadni.

-- az f4-nek két inputja van, ha csak egyet vezetünk be = előtt, akkor
-- (Int -> Int) függvényt kell megadni.
f4'' :: Int -> Int -> Int
f4'' x = (\y -> x + y)

f4''' :: Int -> Int -> Int
f4'''  x = (+) x



-- Polimorf függvények
------------------------------------------------------------

-- polimorf: függvény, ami több típuson mûködik
-- (Haskell-ben polimorf függvény: típusában van kisbetûs
--  típusváltozó)

swap :: (a, b) -> (b, a) -- kisbetûs típus: típusváltozó
swap (x, y) = (y, x)

-- polimorf függvényekrõl: egyetlen definíció működik minden specifikus típusra
-- például nem tudunk ilyen függvényt írni:

-- myId :: a -> a
-- myId x = ha x típusa Bool, akkor not x, egyébként x

-- alapvetõ polimorf függvények (alapból be vannak töltve)
-- id :: a -> a
-- id x = x

-- konstans függvény
-- const :: a -> b -> a
-- const x y = x

-- parciális applikáció
myFun :: Int -> Int
myFun = const 10
-- myFun = \_ -> 10


-- Megjegyzés: függványalkalmazás általános szabálya:
------------------------------------------------------------
-- (f :: a -> b)
-- (x :: a)
-- ekkor (f x :: b)

-- specifikus esetek:

-- (f :: Int -> Int)
-- (x :: Int)
-- ekkor (f x :: Int)

-- (f :: Bool -> Double)
-- (x :: Bool)
-- ekkor (f x :: Double)
------------------------------------------------------------

-- szintén alapból betöltött függvény: függvényalkalmazás operátor : ($)
-- ($) :: (a -> b) -> a -> b
-- ($) f x = f x

   -- (f :: a -> b)
   -- (x :: a)
   -- (f x :: b)


-- mire jó a dollár?
-- zárójeleket el lehet hagyni a segítségével
-- a $ jobbra zárójelez, és a leggyengébben köt
-- (valójában nem csinál semmi érdekeset)

-- példa:
div10 = div 10
mul3 = (*) 3

f6 :: Int -> Int
f6 x = div10 (div10 (mul3 (add10 x)))

f6' :: Int -> Int
f6' x = div10 $ div10 $ mul3 $ add10 x


-- ($) egy magasabbrendû függvény
-- ($) :: (a -> b) -> a -> b

-- magasabbrendû függvény:
--   olyan függvény, aminek van függvény típusú inputja, vagy függvény szerepel inputban

-- ($) nem Curry-zett alakban
-- ez is magasabbrendû, mivel az input tartalmaz függvényt
applyFun :: (a -> b, a) -> b
applyFun (f, x) = f x

applyFuns :: (Int -> Int, Int -> Int) -> Int -> Int
applyFuns (f, g) x = f (g x)
                 --  f $ g x
                 --  f (f (g (g x)))
                 -- vagy : f $ f $ g $ g x

f7 :: a -> b -> c -> b
f7 x y z = y

-- feladat: írjunk alábbi típusú függvényt
f8 :: (c -> a -> b) -> (c -> a) -> c -> b
f8 f g x = f x (g x)
 -- tudjuk, hogy:
 -- (f :: c -> a -> b)
 -- (g :: c -> a)
 -- (x :: c)
 -- mi a célunk: b
 -- tehát csak f segítségével tudunk b-t csinálni
 -- tehát, használjuk az f-et:
 -- f ? ?
 -- már van egy c-nk (ami x) tehát az lesz az elsõ argumentum
 -- f x ?
 -- szükség van egy a-ra, és a-t csak g-vel kaphatunk
 -- tehát:
 -- legyen a definíció: f x (g x)

-- Ilyen feladatok megoldását néhol "type tetris" névvel illetik.
-- Fontos készség Haskell-ben, de programozásban általában is.


-- írjunk alábbi típusú függvényt
compose :: (b -> c) -> (a -> b) -> a -> c
compose f g x = f (g x)
   -- lásd matematikai függvénykompozíció:
   -- (f o g)(x) = f(g(x))
