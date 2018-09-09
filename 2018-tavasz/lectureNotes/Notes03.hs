
-- Adjuk meg a listát, ami az 1000-nél nagyobb négyzetszámokat
-- tartalmazza

-- fun :: Double -> Integer
-- fun x = floor (x * x + 100)

-- rekurzív listafüggvényekről (szükséges fogalom: mintaillesztés)

-- mintaillesztés nem-listákon

fun :: Int -> Int
fun 0 = 2000
fun n = 4

not' :: Bool -> Bool
not' True  = False
not' False = True

-- default minta: _ mindenre illeszkedik
not'' :: Bool -> Bool
not'' True = False
not'' _    = True

and' :: Bool -> Bool -> Bool
and' True b2 = b2
and' _    _  = False

-- további lista minták:
-- akármilyen lista literálra is lehet mintát illeszteni
-- minták lehetnek egymásba ágyazottak is

-- kisbetűs név : bármire illeszkedik, hivatkozhatunk
--                az értékre az = után

-- _ : bármire illeszkedik, de nem hivatkozhatunk az értékre

-- példa helyes mintákra az = bal oldalán
-- listFun :: [Int] -> [Int]
-- listFun []              = undefined
-- listFun [0]             = undefined
-- listFun (0:1:2:3:[])    = undefined
-- listFun (x:y:foobar:[]) = undefined
-- listFun (n:ns)          = undefined
-- listFun (x:y:xs)        = undefined
-- listFun _               = undefined

-- nem vég-rekurzív
sum' :: [Int] -> Int
sum' []     = 0
sum' (n:ns) = n + sum' ns

-- ("go" : gyakori segédfüggvény név)
-- vég-rekurzív, akkumulátorral
sum'' :: [Int] -> Int
sum'' ns = go ns 0 where
  go :: [Int] -> Int -> Int
  go []     acc = acc
  go (n:ns) acc = go ns (acc + n)

-- Mintaillesztés tuple-ökre

swap :: (Int, String) -> (String, Int)
swap (n, str) = (str, n)

fst' :: (a, b) -> a
fst' (n, _) = n

swap' :: (a, b) -> (b, a)     -- kisbetű: "bármilyen" típus
swap' (a, b) = (b, a)

id' :: a -> a
id' x = x

-- magic :: a -> b  -- típusbiztonság ezt kizárja
-- magic x =        -- (akármiről akármire konvertál)

-- ha három vagy több elemű tuple-t használunk,
-- akkor mintaillesztéssel lehet dolgozni, pl:

fstFrom4 :: (a, b, c, d) -> a
fstFrom4 (x, _, _, _) = x  -- jó gyakorlat: _ minta arra, ami nem használt

firstAndThirdFrom4 :: (a, b, c, d) -> (a, c)
firstAndThirdFrom4 (x, _, y, _) = (x, y)

------------------------------------------------------------

zip' :: [a] -> [b] -> [(a, b)]
zip' (a:as) (b:bs) = (a, b):zip' as bs
zip' _      _      = []
-- zip' (a:as)     [] = []    -- a maradék esetek kifejtve
-- zip' []     (b:bs) = []
-- zip' []         [] = []

-- id'' :: a -> a
-- id'' a = a

-- alkalmazzunk egy függvényt egy lista
-- minden elemére
-- 1. input: egy függvény
-- 2. input: egy lista
--    output: egy lista
map' :: (a -> b) -> [a] -> [b]
map' f []     = []
map' f (a:as) = (f a) : (map' f as)

-- bónusz kérdés:
-- hány féle ((a -> b) -> [a] -> [b])
-- típusú függvényt lehet csinálni (végtelen loop,
-- és kivételek nélkül)?

-- hány féle (a -> a) típusú függvény van?
id'' :: a -> a
id'' x = x

-- sort :: -- olyan típusa lesz, hogy
--         -- kizárólag helyes rendezőalgoritmusok
--         -- az értékei

-- tail recursive (vég rekurzív)

-- [1, 2, 3]  szintaktikus cukor
-- (1 : (2 : (3 : []))) == [1, 2, 3]

-- más stílust igényel, mint a tömb
-- Haskell-ben van tömb is

--

-- xs :: [Int]
-- (x : xs) :: [Int]
-- take 1000 (map ... ..)
