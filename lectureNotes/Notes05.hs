
-- Minta zh:
----------------------------------------

-- infixr : jobbra zárójelez:
-- infixl : balra zárójelez
-- infix  : több alkalmazás szintaktikai hiba (nem egyértelmű)

-- ghci-ben: :i operátor (kötési irány, erősség)

-- több `function` egymás után: akkor ezeket balra
-- kell zárójelezni, és erősebben köt, mint bármely
-- "igazi" operátor

-- >  : infix  4
-- ^  : infixr 8
-- || : infixr 2
-- && : infixr 3

-- vagy: nézzük meg, hogy mi a típusa a kifejezésnek,
-- és úgy zárójelezzünk, hogy jó típus legyen az eredmény
-- azt is nézzük, hogy közben nem változik a végeredmény
-- 1^1^1

exp' :: Integer -> Integer -> Integer
exp' x y = x ^ y

-- 121 `mod` 9 `div` 5 == (2 ^ 3 ^ 2 - 3 * 22 - 6) && (5 > (2 * 5 ^ 2) || (3 + (7 - 2)) * 3 > 10)

-- isInteger :: Double -> Bool
-- isInteger n = (fromIntegral (round n :: Int) :: Double)
--               == n

-- minta: pitagoraszi megoldás:
solution = [(a, b, c) | a <- [1..150], b <- [1..150], let c = sqrt(a*a + b*b), a + b + c  == 150]

-- Magasabbrendű függvények folyt.
----------------------------------------

-- korábban: map, filter,
-- dropWhile, takeWhile
dropWhile' :: (a -> Bool) -> [a] -> [a]
dropWhile' pred []     = []
dropWhile' pred (a:as) =
  if pred a then dropWhile' pred as
            else a:as
-- Ctr-c Ctrl-c : ghci interrupt

-- alapvető magasabbrendű függvényeket
----------------------------------------

id' :: a -> a
id' a = a

const' :: a -> b -> a
const' a _ = a

-- fv. applikáció és fv. kompozíció

-- ($) :: (a -> b) -> a -> b
-- ($) f a = f a

-- praktikusan: szintaktikus kényelmi eszköz
-- $: zárójelek kiírtására alkalmas
-- sum (filter even (map ((+) 1) [0..10]))

-- standard: zipWith függvény
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' f (a:as) (b:bs) = f a b : zipWith' f as bs
zipWith' f _      _      = []

-- zipWith ($) [(+)20, (+)30] [10, 10]
-- zipWith (\f a -> f a) [(+)20, (+)30] [10, 10]

-- standard: flip
-- flip :: (a -> b -> c) -> b -> a -> c

flip' :: (a -> b -> c) -> b -> a -> c
flip' f b a = f a b

-- flip-et akkor használhatjuk, amikor nem jól jön ki éppen
-- az argumentumok sorrendje

-- második listát vágja le az első lista hosszára:
-- zipWith (flip const) [1, 2] [1, 2, 3]

-- függvénykompozíció:
-- f . g : azt akarja ábrázolni, mint
-- a matematikai (f ∘ g)

-- standard: (.) operátor
-- (.) :: (b -> c) -> (a -> b) -> a -> c
-- (f . g) x = f (g x)

-- mire jó a (.): lambdákat lehet kiírtani:
-- csak egyszerűen kombináljuk az egymás után
-- alkalmazandó függvényeket, az argumentumok
-- nevesítése nélkül

-- (*) 20 . (+) 10 = \x -> (*) 20 ((+) 10 x)
--                 = \x -> 20 * (10 + x)

-- operátorokkal lehet még ún. szekciót csinálni:
--

-- (10+) == (\x -> 10 + x)
-- (+10) == (\x -> x + 10)

-- (++"foo") == (\x -> x ++ "foo")
-- ("foo"++) == (\x -> "foo" ++ x)

-- map ((*20) . (+10)) [0..10]

-- map (\x -> x ++ "!")  ["alma", "körte"]

-- map ((++ "!"))  ["alma", "korte"]
-- map (("!"++))  ["alma", "korte"]
-- a kettő fenti nem ugyanaz
