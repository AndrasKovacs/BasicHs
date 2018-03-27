
import Data.List (sort, group) -- sort

-- Adjuk meg az alábbi ?-el jelölt típust
-- (a legáltalánosabb típust adjuk meg)

f :: (a -> a -> b) -> a -> b
f g x = g x x

-- 1. lépés : f-nek két argumentuma van:
-- f :: ? -> ? -> ?
-- 2. lépés : g-nek szintén két argumentuma van
-- f :: (? -> ? -> ?) -> ? -> ?
-- 3. lépés : g-nek ugyanolyan típusúak
--                  az argumentumai
-- f :: (a -> a -> ?) -> ? -> ?
-- 4. lépés : x típusa = g argumentum típusa
-- f :: (a -> a -> ?) -> a -> ?
-- 5. lépés : f visszatérési típusa azonos
--            g visszatérési típusával
-- f :: (a -> a -> b) -> a -> b

-- f2 :: ?
f2 f x = f x

-- 1. két argumentuma van: f2 :: ? -> ? -> ?
-- 2. f egy függvény: f2 :: (? -> ?) -> ? -> ?
--          (mivel: látjuk, hogy "f x" szerepel)
-- 3. f input típusa = x típusa: f2 :: (a -> ?) -> a -> ?
--          (mivel: látjuk, hogy "f"-et "x"-re alkalmazzuk)
-- 4. f2 visszatérési típusa = f vissz. típusa:
--          (mivel: f2 "f x" -el tér vissza)
--    f2 :: (a -> b) -> a -> b

-- Házi feladatok (opcionális)
-- (ezek mind standard függvények)
f3 f g x = f x (g x)
f4 f = f (f4 f)
f5 f g h x = f (g x) (h x)


f6 f g x = f (g x)

-- 3 argumentum: f6 :: ? -> ? -> ? -> ?
-- f és g is függvények: f6 :: (? -> ?) -> (? -> ?) -> ? -> ?
-- g arg. típusa = x típusa: f6 :: (? -> ?) -> (a -> ?) -> a -> ?
-- f arg. típusa = g visszatérési típusa:
--               f6 :: (b -> ?) -> (a -> b) -> a -> ?
--               (mivel "f"-et "g x"-re alkalmazzuk)
-- f6 visszatérési típusa = f vissz. típusa:
--               f6 :: (b -> c) -> (a -> b) -> a -> c

-- f6 = függvénykompozíció
-- (.) :: (b -> c) -> (a -> b) -> (a -> c)
-- (f . g) x = f (g x)

comp3 :: (c -> d) -> (b -> c) -> (a -> b) -> a -> d
comp3 f g h x = f (g (h x))

-- comp4 etc. ugyanígy

-- lényeges különbség: az összes függvény (a -> a)

composeAll :: [a -> a] -> a -> a
composeAll []     a = a
composeAll (f:fs) a = f (composeAll fs a)
-- composeAll [f, g, h] a = f (g (h a))

-- cseréljük üres listát: identitás függvényre
--           :-ot       : függvénykompozícióra
-- composeAll' (f:g:h:[])
--          =   f.g.h.id
--          =   f ∘ g ∘ h ∘ id
composeAll' :: [a -> a] -> a -> a
composeAll' = foldr (.) id

-- ennek a függvénynek milyen definíciói vannak?
-- szükségképpen parciális (azaz: exception-t dobhat)
-- (nem teljes mintaillesztéssel definiálható)
foo :: [a -> b] -> (a -> b)
foo (f:_) = f
-- üres listából nem tudunk valamit kivenni

-- redundáns (== True)
ifthenelseExample :: Bool -> String
ifthenelseExample b = if b == True then "foo" else "bar"
                   -- if b then "foo" else "bar"
                   -- bármilyen if-then-else-es nyelvben igaz

-- stilisztikai észrevétel (6.heti házikkal kapcs)
-- ahol lehet, kerüljük a parciális függvényeket
-- mint. pl. head, tail
-- mert ezek dobhatnak kivételt (üres listán)


-- head xs OK ha xs nem üres
-- de ha nem üres, akkor mindig (x:xs')-re bontható
-- head xs helyett azt használom, hogy x
-- tail xs helyett azt használom, hogy xs'
-- defenzívebb programozás

-- példa megoldás 6.heti házira
-- case használata itt előnyös
groupBy :: (a -> a -> Bool) -> [a] -> [[a]]
groupBy pred []     = []
groupBy pred (a:as) = case groupBy pred as of
  []             -> [[a]]
  ((a':as'):ass) -> if pred a a' then (a:a':as'):ass
                                 else [a]:(a':as'):ass
  ([]:ass)       -> error "impossible"

-- filozófiailag két hozzáállás:
-- 1. soha nem dobunk kivételt, úgy hogy minden mintaillesztés
--    teljes, és nem használunk error-t (vagy ilyesmit)
-- 2. bizonyítjuk, hogy a kódunk nem dob kivételt, még ha
--    tartalmaz nem teljes mintát is (vagy error-t)

-- opcionális házi feladat:
-- bizonyítsuk be az groupBy input listáján
-- történő indukcióval, hogy az "error "impossible"" soha
-- nem hívódik meg

-- jegyzetből: trim (szóközök eldobása elülről + hátulról)

dropSpaces :: String -> String
dropSpaces = dropWhile (==' ')

-- függvények komponálása (jobbról balra alkalmazzuk a
--                         függvényeket)
trim :: String -> String
trim = reverse    -- 4. visszafordítjuk
     . dropSpaces -- 3. dobjuk el az elejéről a ' '-eket
     . reverse    -- 2. reverse
     . dropSpaces -- 1. dobjuk el az elejéről a ' '-eket

-- Ord a : a típusú dolgokra tudjuk a <, <=, >, stb. függvényeket
--         használni

-- 1. lépés: minden részlista legkisebb elemét vegyük
minimums :: Ord a => [[a]] -> [a]
minimums = map minimum

maximumOfMinimums :: Ord a => [[a]] -> a
maximumOfMinimums = maximum . map minimum


-- map :: (a -> b) -> [a] -> [b]

mapMap :: (a -> b) -> [[a]] -> [[b]]
mapMap f = map (map f)
         -- mapMap f = f (g x)
         --    ahol f = map, és g = map és x = f
         -- visszafelé a (.) definíciója szerint
         -- mapMap = map . map

mapMap' :: (a -> b) -> [[a]] -> [[b]]
mapMap' = map . map

-- map ? ass :: [[b]]
--     ?     :: [a] -> [b]
--     ? legyen (map ?)
--              (map ?) :: [a] -> [b]
--                   ?  :: a -> b
--                   ? legyen f


firstLetters :: String -> String
firstLetters = map head . words

words' :: String -> [String]
words' =

  -- 2. lépés: hagyjuk meg az olyan rész-Stringeket,
  -- amelyekben legalább egy nem ' ' karakter va
  filter (all (/=' ')) .

  -- 1. lépés: bontsuk föl a Stringet olyan rész-Stringekre
  -- amelyekben vagy csak ' ' van, vagy pedig csak nem ' ' van.
  groupBy (\c1 c2 -> ((c1 == ' ') && (c2 == ' '))
                  || ((c1 /= ' ') && (c2 /= ' ')))

-- példa olyan implementációra, ahol nincs lehetőség
-- fold/map stb. trükkökre
-- Ebben az esetben csak megírjuk rekurzívan a függvényt.
insertChar :: Char -> String -> String
insertChar c []      = []
insertChar c [c']    = [c']
insertChar c (c':cs) = c':c:insertChar c cs

-- példa : insertChar ' ' "abc" == "a b c"
-- nem szeretnénk, hogy az utolsó karakter után is beszúrjon
--         insertChar ' ' "" == ""

-- szúrjuk be String-et minden két String közé
intercalate :: String -> [String] -> String
intercalate s []      = []
intercalate s [s']    = s'
intercalate s (s':ss) = s' ++ s ++ intercalate s ss

monogram :: String -> String
monogram =
    intercalate " "              -- ragasszuk őket " "-vel össze
  . map (\str -> head str : ".") -- 2. kezdőbetűk (és utána '.')
  . words -- 1. szavakat

-- ismétlődő elemek elhagyása
reduce :: Eq a => [a] -> [a]
reduce =
    map head     -- 2: ismételődő elemek eldobása egy kivételével
  . groupBy (==) -- 1: ismétlések csoportosítása

-- megjegyzés: group = groupBy (==)
-- (group, groupBy: Data.List modulban vannak)

uniq :: Ord a => [a]{-véges-} -> [a]
uniq = map head . group . sort

-- uniq' :: Ord a => [a]{-véges-} -> [a]
-- uniq' megőrzi az elemek eredeti sorrendjét















































































-- if t == True
-- parciális
-- case használata
-- jegyzet: függvénykompozíció + hajtogatások
