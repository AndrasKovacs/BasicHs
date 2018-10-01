
-- 4. gyakorlat
------------------------------------------------------------

-- 3. házi feladat bónusz:

-- Hoogle: típusra lehet keresni (házi megoldást lehet keresni típus alapján)

--   emlékeztető: curry-zett függvény: többparam-os fv. reprezentálása
--     függvényt visszaadó függvénnyel

-- magasabbrendû függvény, ami curry-z egy input függvényt
--   bemenet: két param-os függvény, ami párt kap
--   kimenet: két param-os függvény, ami curry-zett
curry' :: ((a, b) -> c) -> (a -> b -> c)
    -- :: ((a, b) -> c) -> a -> b -> c
curry' f x y = f (x, y)
  -- mit tudunk: f :: (a, b) -> c
  --             x :: a
  --             y :: b
  -- mit szeretnénk: c
  -- mivel tudunk c-t csinálni: f-el
  -- tehát f-nek mit adjunk oda: egy (a,b) párt
  -- hogy tudunk (a,b) párt csinálni: (x, y)

  -- stratégia: 0. soroljunk fel minden függvény param-ot
  --               (= bal oldalán, vagy lambdával)
  --            1. mit tudunk (minek mi a típusa)
  --            2. mit szeretnénk megadni (visszatérési típus)
  --            4. használjunk függvényalkalmazást és ismert függvényeket

-- ghci-ben szintén: curry :: ((a, b) -> c) -> a -> b -> c

-- nem curry-zett (+)
add :: (Int, Int) -> Int
add (x, y) = x + y

-- curry :: ((a, b) -> c) -> (a -> b -> c)
add' :: Int -> Int -> Int
add' = curry' add

-- add' 10 20 == 30
-- (+)  10 20 == 30

-- lépésenként, hogyan értékeljük ki: add' 10 20
-- 1. add' 10 20            -- add' definíció alapján
-- 2. curry' add 10 20      -- curry' def. alapján
-- 3. add (10, 20)          -- add def. alapján
-- 4. 10 + 20               -- (+) alapmûvelet
-- 5. 30

-- (általánosan: kiértékelés végigvezetése: = definíciók
--  egymás utáni behelyettesítése)

-- referenciális transzparencia:
--  = bal oldalán levõ dolgot mindig kicserélhetjük a jobb oldalon
--  levõ kifejezés értékével

--  ha igaz a referenciális transzparencia:
--    akkor igaz, hogy a teljes program helyes,
--    ha külön-külön minden része (pl. kifejezés, függvény)
--    helyes.
--  Imperatív programokra ez általánosan nem igaz:
--     Pl: ha egy függvény definíciója hivatkozik egy átírható (mutálható)
--         változóra, akkor a függvény viselkedése nem csak az inputoktól függ,
--         hanem a mutálható változó pillanatnyi értékétől is.


--  funckionális vs. imperatív sztori:

--   általában: imperatív nyelvekben lehet funkcionálisan programozni (csak gyakran kényelmetlen)
--              funkc. nyelvben lehet imperatívan programozni         (csak gyakran kényelmetlen)
--   a kettõ között kell valamilyen egyensúlyt találni

--   funkc: könnyebb helyes programot írni, könnyebb tesztelni
--          könnyebb párhuzamos programot írni

--   imperatív: könnyebb gyorsabban futó programot írni
--              bizonyos algoritmusokat intuitívabb
--              imperatívan definiálni

-- A legjobb megoldás gyakran a kettő keverése.
--   Általában: minél funkcionálisabb, annál jobb (tesztelhető, átlátható).
--   De ha a sebesség fontos, akkor néha elkerülhetetlen imperatív részek írása.



-- Rekurzió bevezetés
------------------------------------------------------------

-- általában: funkc. prog-ban
--            loop helyett rekurzív függvényt használunk

-- minden loop átírható rekurzióra
-- nem minden rekurzió írható át loop-ra.
--   ezeket imperatív nyelvben is rekurzióval érdemes
--   definiálni


-- faktoriális: tegyük fel, hogy a bemenet nem negatív Int
-- fact n = "szorozzuk össze 1-tõl n-ig az egészeket"
fact :: Int -> Int
fact 0 = 1     -- üres számhalmaz elemeinek szorzata: 1
               -- (üres számhalmaz elemeinek az összege: 0)
fact n = n * fact (n - 1)

-- rekurzív definíció: ugyanarra a függvényre hivatkozunk
-- a definícióban, mint amit éppen definiálunk

-- példák:
--   fact 1 == 1 * fact 0 == 1 * 1 == 1
--   fact 2 == 2 * fact 1 == 2 * 1 * fact 0 == 2 * 1 * 1
--   fact 3 == 3 * 2 * 1 * 1
--   fact 4 == 4 * 3 * 2 * 1 * 1

-- érdekesség: van egy tetszõleges nagyságú szám típus: Integer
-- Ha nincs Integer-re szükség, akkor Int gyorsabb

fact' :: Integer -> Integer
fact' 0 = 1
fact' n = n * fact' (n - 1)

-- Integer-el a fact' függvény működik nagy számokra is.
-- Int-el csak véges tartományban tudunk számot tárolni, így hamar
-- értelmetlen eredményt kapunk.


-- végtelen loop-ok írása lehetséges rekurzióval:
wrongFact :: Int -> Int
wrongFact 0 = 1
wrongFact n = n * wrongFact n

-- pl. wrongFact 3 == 3 * 3 * 3 * 3 * 3 * ....

-- ghci-ben lelõni végtelen loop-ot a következőképpen lehet:
-- Ctrl-c vagy Ctrl-c-c

loop :: Int    -- nem kell függvény loop-hoz
               -- elég csak egy saját magával definiált
               -- érték.
loop = loop
     -- loop kiértékelése: loop == loop == loop == ....
     -- Ctrl-c vel megszakítjuk



-- listák
------------------------------------------------------------

-- lista típus: ha "a" egy típus, akkor [a]
-- az az "a" típusú elemek listájának típusa

-- példa: [Int] az Int-et tartalmazó listák típusa
list1 :: [Int]
list1 = [0, 1, 2, 3]

list2' :: [Int]
list2' = []

-- [1, 2, 3] jelölés: ez csak egy rövidített jelölés

-- szintaktikus cukorka (syntactic sugar: amikor rövid, tömör jelölést
--   használunk valami bonyolultabban definiált dologra)


-- üres listának csak egyféle jelölése van:
empty :: [Int]
empty = []

-- kiterjesztett lista:
-- egy elemû lista
extended :: [Int]
extended = 1 : []     -- ugyanaz, mint [1]

-- két elemû lista:
list2 :: [Int]
list2 = 0 : 1 : []    -- ugyanaz, mint [0, 1]

-- pl. (0 : 1 : 2 : 3 : []) == [0, 1, 2, 3]

-- tehát: két módja van lista megadásának
-- elsõ: []
-- második: (:) operátor használata:
--           ha van egy listaelem, és van egy lista akkor, a (:)
--           operátorral a lista elejére tesszük az elemet, és így
--           kapunk egy új listát

-- (:) operátor jobbra zárójelez:
-- tehát:   0 : (1 : [])             -- [0, 1]       vagy (0 : 1 : [])
--          10 : (20 : (30 : []))    -- [10, 20, 30] vagy (10 : 20 : 30 : [])

-- a (:) operátor minden alkalazása balról kiegészít egy listát egy elemmel.
-- Pl: ha kétszer kiegészítjük az üres listát balról: (0 : 1 : [])

-- mi típusa a (:)-nak, és a []-nak?

-- Az üres lista bármilyen lista típusnak az értéke,
-- mivel az üres listából nem derül ki semmi az elemek típusáról.
-- [] :: [a]

-- (:) neve néha: lista kiegészítés
--     angolul neve: cons
--             (eredet: 1960-as évek, Lisp nyelv)

-- (:) :: a -> [a] -> [a]
-- tehát: tetszőleges típusú elemmel kiegészíthetűnk egy olyan elemtípusú listát


-- Emlékeztető: Bool értékeit kétféle képpen tudtuk megadni:
--     True  :: Bool
--     False :: Bool

-- tehát: mintaillesztést Bool-on úgy csináltunk, hogy ezt a két esetet vizsgáltuk.

-- Listát kétféleképpen tudunk létrehozni: [], (:)
-- tehát listán err a két formára tudunk mintát illeszteni.


-- példa: döntsük el, hogy egy lista üres-e.
isEmpty :: [a] -> Bool
isEmpty []     = True
isEmpty (x:xs) = False
   -- a második sorban az "x" az input lista első elemére hivatkozik
   --- az "xs" pedig a lista fennmaradó részér, amiben már nincs benne az első elem.

-- Mivel a nemüres lista esetben nem érdekel minket az input,
-- jó a következő definíció is:
isEmpty' :: [a] -> Bool
isEmpty' [] = True
isEmpty' _  = False


-- lista hossza: rekurzív függvény:
length' :: [a] -> Int
length' []     = 0
length' (x:xs) = length' xs + 1

-- példa: length' [0, 1, 2]
--        length' (0:(1:(2:[])))
--        length' (1:(2:[])) + 1
--        length' (2:[]) + 1 + 1
--        length' [] + 1 + 1 + 1
--        0 + 1 + 1 + 1
--        3

-- vagy pedig:
--        length' [0, 1, 2]
--        length' [1, 2] + 1
--        length' [2] + 1 + 1
--        length' [] + 1 + 1 + 1
--        0 + 1 + 1 + 1
--        3

length'' :: [a] -> Int
length'' []     = 0
length'' (x:xs) = 1 + length'' xs
-- length'' [0, 1, 2]
-- 1 + length'' [1, 2]
-- 1 + 1 + length'' [2]
-- 1 + 1 + 1 + length'' []
-- 1 + 1 + 1 + 0
-- 3


-- A length' függvény nem loop-ol, mivel a rekurzív length' alkalmazás kisebb listán
-- történik, mint a bemenet lista. Tehát minden rekurzív hívásnál csökken a lista
-- mérete, és előbb-utóbb elérjük az üres listát, ahol nincs több rekurzív hívás.
