
-- bináris szám --> Integer

-- először: direkt definíció
-- aztán: magasabbrendű fv. definíció

-- bináris szám reprezentáció?
-- Bool lista: True = 0, False = 1

boolToInteger :: Bool -> Integer
boolToInteger b = if b then 1 else 0

fromBin :: [Bool] -> Integer
fromBin bs = go 1 bs where
  -- extra paraméter: helyi érték
  go :: Integer -> [Bool] -> Integer
  go ertek []     = 0
  go ertek (b:bs) = boolToInteger b * ertek +
                    go (ertek*2) bs

-- egyszerűbb implementálni, hogy a
-- első számjegy a legkisebb helyi értékű

-- példa: fromBin [False, False, True] -- 100
--        == 4
--

fromBin2 :: [Bool] -> Integer
fromBin2 bs =
  sum (zipWith (\e b -> e * boolToInteger b) helyi bs)
  where helyi = iterate (*2) 1
   -- vagy : helyi = [2^n | n <- [0..]]
   -- vagy : helyi = map (2^) [0..]

-- fromBin3 :: [Bool] -> Integer
-- fromBin3 = _

-- iterate, Scanr, Scanl
----------------------------------------

-- f-et iteráljuk, (alkalmazzuk n-szer, mindegyik
-- eredményt visszaadjuk)
iterate' :: (a -> a) -> a -> [a]
iterate' f a = a : iterate' f (f a)

-- példa: take 10 (iterate (+1) 0) == [0..9]
-- példa: take 10 (iterate (*2) 1)

-- "jegyzet: hajtogatások részeredményekkel"
-- scanr, scanl

-- scanr:
--   foldr-hez hasonló, de
--   összes részeredményt visszaadja

-- példa : scanr (+) 0 [1, 1, 1, 1]
--      == [4,3,2,1,0]

-- részeredmények a lista "farkaira" vonatkoznak
-- foldr (+) 0 [1, 1, 1, 1] ==
--       (1 + (1 + (1 + (1 + 0))))

-- jobbra zárójelezett részeredmények

-- emlékeztető :
--   foldr :: (a -> b -> b) -> b -> [a] -> b

scanr' :: (a -> b -> b) -> b -> [a] -> [b]
scanr' f b []     = [b] -- pl: scanr (+) 0 [] == [0]
scanr' f b (a:as) = f a (head bs) : bs
  where bs = scanr' f b as

-- extra házi: head nélküli implementáció?

-- kvardatikus definíció lenne:
-- n-darab ++-t hajt végre, minden ++ lineáris
-- költségű

-- scanl' :: (b -> a -> b) -> b -> [a] -> [b]
-- scanl' f b []     = [b]
-- scanl' f b (a:as) = scanl' f b as ++ ?

-- scanl implementáció:
--   házi feladat
--   extra: olyan implementációt kell csinálni
--   ami nem kvadratikus

-- fibonacci sorozat scan-el

-- scanr1, scanl1 (analóg módon foldr1, foldl1 -el)
-- példa : scanr1 (+) [0, 1, 2, 3] == [6,6,5,3]
--         scanl1 (+) [0, 1, 2, 3] == [0,1,3,6]

-- finbonacci: scanl segítségével
fibs :: [Int]
fibs = 0 : scanl (+) 1 fibs

-- scanl (+) 1: olyan függvény, ami
-- lista részösszegeinek listáját adja (balról)
-- kezdőérték 1

-- lehetséges stratégia a működés megértésére:
-- nézzük meg (scanl (+) 1) működését
--   egyre hosszabb fibonacci sorozatokra

-- [0,1,1,2,3,5,8,13,21,34]
-- scanl (+) 1 [0, 1] == [1, 1, 2]
-- scanl (+) 1 [0, 1, 1] == [1,1,2,3]
-- scanl (+) 1 [0, 1, 1, 3] == [1,1,2,3,6]

-- másik fib definíció
-- (egyszerűbb, de szintén rekurzív)
fibs' :: [Integer]
fibs' = 0: 1: zipWith (+) fibs' (tail fibs')
--            egymást követő elemek összegei

-- fibs'      = 0, 1, 1, 2, 3 ...
-- tail fibs' = 1, 1, 2, 3, ....

-- páronként összeadjuk:
-- zipWith fibs' (tail fibs')
--            = 1, 2, 3, 5, 8, etc...

-- tehát: egymást követő elemek összege
--        adja meg a következő elemet mindig
--        (0, 1 után)

-- rekurzív definíció (mint sorozat)
-- fibs' !! 0       == 0
-- fibs' !! 1       == 1
-- fibs' !! (n + 2) == fibs' n + fibs' (n + 1)

-- Lusta kiértékelési modell (implementáció?)
---------------------------------------------

-- gyakorlat :
-- kézzel levezetni: fibs !! 3 értéke

-- (!!) egyenlőségei alapján
-- és fibs definíciója alapján

-- (!!) definíciója:
ix :: [a] -> Int -> a
ix []     _ = error "HIBA"
ix (a:as) 0 = a
ix (a:as) n = ix as (n - 1)

-- kifejteni definíciók szerint: ix fibs 2

-- ix fibs 2

-- ix (0:1:zipWith (+) fibs (tail fibs)) 2

-- ix (1:zipWith (+) fibs (tail fibs)) 1

-- ix (zipWith (+) fibs (tail fibs)) 0

-- ix (zipWith (+) (0:1:zipWith (+) fibs (tail fibs))
--                 (1:zipWith (+) fibs (tail fibs))) 0

-- ix (0 + 1: zipWith (+)
--             (1:zipWith (+) fibs (tail fibs))
--             (zipWith (+) fibs (tail fibs))) 0

-- 0 + 1

-- Tehát
----------------------------------------

-- (rekurzív fv. definíció, de nincs
--  rekurzív érték definíció
--  általában szigoró nyelvekben)

-- int foo(int x) {return foo(x + 1);}
-- int x = x + 1

-- lehetnek végtelen átírási láncok, ha összevissza
-- írunk át balról jobbra,

-- Haskell: lusta kiértékelési stratégia:
-- csak addig értékelünk listát (és más adatot)
-- hogy kiderüljön, hogy melyik minta illeszkedik

-- Háttér: hogy implementáljuk ezt úgy gépi kódban,
-- hogy legyen piszok lassú? (Nem anyag, érdekes téma)

-- Pl Haskell:

-- általánosan igaz, hogy lusta program,
-- lassabb valamivel, mint egy ekvivalens szigorú
-- program.

-- több programot írhatunk loop nélkül,
-- de némi futásidejű költséggel



(a -> b) -> [a] -> [b]

(a -> [a]) -> [a]
