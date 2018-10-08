
-- Rekurzív lista fv. (folytatás)
--------------------------------------------------

-- korábbi példák: length, append (++), map

-- standard függvény: take
-- take n xs: vegyük az elsõ n elemét az xs listának
-- és azt adjuk vissza listaként

-- tételezzük fel, hogy az Int paraméter nem negatív

-- rekurzív függvénynél: milyen paraméter fog minden hívásnál
-- "csökkenni": minden rekurzív hívásnál a paraméter közeledik
-- egy olyan esethez, amikor már nincs több rekurzív hívás.

-- Olyan eset amikor nincs több rekurzív hívás: "base case".

-- legyen az Int az a paraméter, ami csökken.
take' :: Int -> [a] -> [a]
take' 0 xs     = []  -- vegyünk 0 elemet xs-bõl
take' n []     = []  -- nem tudunk elemet venni
take' n (x:xs) = x : take' (n - 1) xs -- tudunk venni elemet
  -- mivel az eredményben már x benne van,
  -- ezért n-1 elemet kell xs-bõl venni

  -- mi történik negatív Int-nél?
  -- take' (-3) [] == []
  -- take' (-3) [1] == 1 : take' (-4) []
  --                == 1 : []

  -- tehát a fenti definíció negatív Int esetén
  -- visszaadja az egész listát

  -- standard take függvény: negatív Int-nél üres listát
  -- ad vissza

-- standard take definíció:
-- meg kell vizsgálni, hogy n negatív-e, ha igen, akkor []-t visszaadni.

-- összehasonlítás: (<), (<=), (>), (>=)
--   mindegyik operátor hasonló (==)-hez, abban hogy több típuson
--   mûködik, viszont a két paraméter típusa ugyanaz kell, hogy
--   legyen.
--   Bool eredményt ad minden összehasonlítás.
--   Működik: Int, Double, Bool
--   Bool esetén: False kisebb True-nál (ghci-ben: (False < True) == True)

-- listák összehasonlítása: pontosan akkor működik, ha
-- a lista elemeit is össze lehet hasonlítani

-- pl: [0, 1] < [1, 1] == True
--     [0] < [0, 1]    == True
-- általánosan: "ábécé" sorrendben összehasonlítás
-- szakkifejezés: lexikografikus sorrend

-- (==) listákra is mûködik, akkor, ha van (==) a lista elemeire.


take'' :: Int -> [a] -> [a]
take'' n xs =
  if n <= 0
    then []
    else case xs of
           []   -> []
           x:xs -> x : take'' (n - 1) xs

    -- az egész case kifejezés egy kifejezés
    -- else (case xs of
    --        []   -> []
    --        x:xs -> x : take'' (n - 1) xs)

    -- (case kifejezés bárhol alkalmazható)

-- õrfeltétel (guard)
-- valamilyen mintát kiegészíthetünk egy Bool típusú
-- feltétellel
--

take''' :: Int -> [a] -> [a]
take''' n xs | n <= 0 = []
take''' n []          = []
take''' n (x:xs)      = x : take''' (n - 1) xs

-- (= és paraméterek egy oszlopba húzása: ízlés kérdése)

-- több guard megadása egy mintához
-- otherwise :: Bool
-- otherwise = True
-- (otherwise: csak olvashatóságot javítja guard-ok esetén)

-- ha egy mintához több guard-ot írunk, akkor
--  azokat ugyabba az oszlopba kell behúzni
f1 :: Int -> Int
f1 n | n < 10    = 2
     | n < 0     = 3
     | otherwise = 30
f1 1000 = 0
f1 _    = 5000


-- standard drop: hagyjuk el az elsõ n elemet egy listából
-- önálló implementáció
drop' :: Int -> [a] -> [a]
drop' n xs | n <= 0 = xs  -- nem akarunk semmit elhagyni
drop' n []          = []  -- semmit nem tudunk elhagyni
drop' n (x:xs)      = drop' (n - 1) xs
                    -- szeretnénk legalább 1 elemet elhagyni
		    -- és nemüres a bemenõ lista

-- magasabbrendû (map, filter)
-- két nagyon nagyon gyakran használt listafüggvény

-- map' (\x -> x + 10) [0, 1, 2, 3] == [10, 11, 12, 13]
-- map' id [0, 1, 2] == [id 0, id 1, id 2]
--                   == [0, 1, 2]

-- a típusú elemekre a függvényt alkalmazzuk, akkor
-- b típusú elemeket kapunk

-- egyértelmû, hogy min illesztünk mintát
--   (függvényen nincs mintaillesztés)
map' :: (a -> b) -> [a] -> [b]
map' f []     = [] -- üres lista elemein függvény alkalmazása
map' f (x:xs) = f x : map' f xs
  -- x: xs alakú lista minden elemén függvény alkalmazása:
  --    elõször alkalmazzuk az x-en
  --    aztán a lista hátralevõ részén rekurzívan

-- olyan függvény, ami nem csinál semmit
-- de rekurzívan feldolgozza a bemenetet
-- és a felépíti ugyanazt a listát kimenetként
mapId :: [a] -> [a]
mapId []     = []
mapId (x:xs) = x : mapId xs

-- másik implementáció
mapId' :: [a] -> [a]
mapId' xs = xs

mapId'' :: [a] -> [a]
mapId'' = id

-- kiértékelés:
-- map ((+) 10) [1, 2, 3]
-- (+) 10 1 : map ((+) 10) [2, 3]
-- (+) 10 1 : (+) 10 2 : map ((+) 10) [3]
-- (+) 10 1 : (+) 10 2 : (+) 10 3 : map ((+) 10) []
-- (+) 10 1 : (+) 10 2 : (+) 10 3 : []
-- 11 : 12 : 13 : []
-- [11, 12, 13]


-- filter: egy listában csak azokat az elemeket
-- hagyja bent, amelyekre igaz valamilyen feltétel
-- (csak xs-re lehet mintát illeszteni)
filter' :: (a -> Bool) -> [a] -> [a]
filter' f []     = []
filter' f (x:xs) | f x       = x : filter' f xs
                 | otherwise = filter' f xs

  -- if-then-else-el:
  -- filter' f (x:xs) =
  --   if f x
  --      then x : filter' f xs
  --      else filter' f xs

  -- példa:
  -- filter (\x -> x < 10) [6, 7, 8, 9, 10, 11]
  --   == [6, 7, 8, 9]
  -- filter ((==) 0) [0, 1] == [0]

-- rekurzív Int függvény, amivel listákat adunk meg
-- count :: Int -> Int -> [Int]
-- soroljuk föl az elsõ paramétertõl a másodikig
-- a számokat egy listában

-- count 0 10 == [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
-- count 0 0 == []
-- count 10 0 == []


count :: Int -> Int -> [Int]
count from to | from >  to = []
              | from == to = [from]
              | otherwise  = from : count (from + 1) to

-- beépített jelölés count-ra:
-- [0..10] == [0,1,2,3,4,5,6,7,8,9,10]

-- (inklúzív intervallum jelölés)
list1 :: [Int]
list1 = [0..10]

-- többet tud a count-függvénynél
-- megadhatunk lépésközt is
list2 :: [Int]
list2 = [0, 2 .. 10]   -- kettesével lép 0-tól 10-ig
  -- hasonlóképpen: [0, 5 .. 20] -- ötösével
  -- csökkenõ lista: [10, 9 .. 0]

-- intervallum, lépésközös intervallum: csak rövidítés
-- definiált függvényekre (enumFromTo, enumFromThenTo)
