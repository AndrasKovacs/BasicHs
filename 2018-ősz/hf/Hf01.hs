

-- 1. feladat

-- Az "undefined" egy olyan érték, amelyet akárhol használhatunk
-- (akármilyen típusa lehet), viszont kiértékeléskor csak egy
-- hibaüzenetet ad.

-- Az "undefined"-okat alább helyettesítsd definíciókkal.  Tetszőleges
-- definíciókat adhatsz, a lényeg, hogy típushelyes legyen, és ne
-- tartalmazzon "undefined"-t. Függvényekhez lambdát vagy explicit
-- paramétereket egyaránt használhatsz.

f1 :: Int -> Int -> Int
f1 = undefined

f2 :: Bool -> Bool -> Int
f2 = undefined

f3 :: Int -> Bool -> Int
f3 = undefined

f4 :: String -> Bool
f4 = undefined

f5 :: Bool -> String
f5 = undefined


-- 2 . feladat

-- A törtszámok (Double) hatványozására a ** operátor használható
-- példa:
dbl1 :: Double
dbl1 = 3 ** 3

dbl2 :: Double
dbl2 = 2 ** 4

-- Kérdés: jobbra vagy balra zárójelezzük a ** -t?
-- Azaz, valamely x, y, z számokra, x**y**z mivel egyenlő,
-- (x**y)**z -vel vagy pedig x**(y**z)-vel? Derítsd ki a ghci
-- segítségével.
-- Válasz:


-- 3. feladat

-- az "if x then y else" konstrukció segítségével megadthatunk egy
-- Bool-tól függő értéket. Példa
int1 :: Bool -> Int
int1 x = if x then 0 else 1

-- ez a függvény True-ra 0-t ad vissza, False-ra pedig 1-et ad vissza

-- további példák: "if True then True else False" értéke True
--                 "if False then True else False" értéke False

-- if-then-else kifejezéssel akármilyen típusú értéket visszaadhatunk,
-- viszont a "then" és az "else" ágban ugyanolyan típusú kifejezésnek
-- kell lennie.

-- Definiáld az összes lehetséges függvényt (undefined használata
-- nélkül) aminek (Bool -> Bool) a típusa!
