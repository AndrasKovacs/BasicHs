{-
Gyak. vezető: Kovács András
      email: kovacsandras@inf.elte.hu
      gyakorlat honlap: github.com/AndrasKovacs/BasicHs
      (2018 ősz mappa)


Tananyagról röviden:

- Haskell nyelvet tanuljuk (kicsi részét)
  - nem szoftverfejlesztés, csak nyelvi alapok

funkc. vs imperatív:

- funkcionális programozás:
  - definíciók sorozata
  - fogalmak: típusok, függvények, rekurzió (talán adatszerkezetek)

- imperatív programozás
  - utasítások sorozata egy program
  - memóriakezelés, utasítások, ciklusok

ghci parancssorból:
  "ghci fájl.hs" : fájlt tölti be
  simán "ghci": fájl nélkül indítjuk, majd ":l fájl.hs" -el tudunk betölteni.

ghci parancsok:
  :q            kilépés
  :?            help
  :l fájl.hs    betölt egy új fájlt
  :r            újratölti a jelenleg betöltött fájlt
                (ha módósítjuk a fájlt, akkor újra kell tölteni)
  :t            megadja kifejezés típusát

-}

-- egysoros komment példa: blabla

{-
  többsoros komment példa:
  blabla
  blabla
  A kommenteket a ghci nem veszi figyelembe betöltéskor
-}


-- Egész számok
------------------------------------------------------------
-- típus: Int
-- egész szám angolul: integer

szam :: Int         -- típusa a definíciónak
szam = 1000         -- értéke a definíciónak

-- általában:
--   definíciók nevei kisbetűvel kezdődnek
--   típusnevek nagybetűvel kezdődnek

szam2 :: Int        -- másik definíció
szam2 = 2000

szam3 = 3000        -- típus opcionális (ha lehagyjuk, akkor ghci kikövetkezteti)
                    -- jó gyakorlat általában: nem hagyjuk le a típust

szam4 :: Int
szam4 = 10

szam5 :: Int
szam5 = szam4 + (szam4 * szam3)     -- zárójelezés precedenciája: +,* szokásos zárójelezés

szam6 :: Int
szam6 = div (10 + 10) 5     -- div után két kifejezés (akár zárójelezett)

szam7 :: Int
szam7 = mod 10 3            -- maradékot megadja

-- logikai értékek
------------------------------------------------------------
-- típusa: Bool   (személy nevéből: George Boole)

log1 :: Bool
log1 = True       -- nagybetűs logikai értékek: True és False

log2 :: Bool
log2 = False

-- logikai műveletek: és, vagy, negáció
log3 :: Bool
log3 = True && False    -- és: &&

log4 :: Bool
log4 = log3 || False    -- vagy: ||

log5 :: Bool
log5 = not True         -- negáció: not

-- logikai műveletek zárójelezése:
--    && erősebb, tehát, először &&-t zárójelezzük, utána a ||-t.

-- függvényalkalmazás matematikában: div(10, 4)
--                    Haskell-ben  : div 10 4

-- Haskell:
--   erősen típusozott: - mindennek van típusa
--                      - program futtatása, kifejezés kiértékelése előtt mindennek ismert a típusa.
--                      - különböző típusok közötti konverziót explicit ki kell írni

-- egyenlőségvizsgálat: ==
------------------------------------------------------------
-- egyenlőségvizsgálat több fajta típuson működik
--   viszont: a két bemenet mindig ugyanolyan típusú kell, hogy legyen

log6 :: Bool
log6 = 100 == 100   -- ne keverjük ==-t (egyenlőségvizsgálat)
                    -- össze az =-el (definíció)

log7 :: Bool
log7 = True == True

-- pl. hibás kifejezés: True == 0


-- törtszámok: típus neve: Double  (más nyelvekben: Float)
------------------------------------------------------------
--   (lebegőpontos számábrázolás: "float"
--    dupla pontosságú lebegőpontos szám: "Double"

double1 :: Double
double1 = 10.5

double2 :: Double
double2 = 10.5 * 2000

double3 :: Double
double3 = 10.5 + 5

-- +, *: működik Int és Double bemenettel is
--       viszont: ugyanolyan típusú lehet csak a két input

-- típust megadhatunk akármilyen kifejezéshez: (kifejezés :: típus)
double4 = (100 :: Double)
szam8 = 10 + (20 + 20 :: Int)

-- tudunk konvertálni Int és Double között

-- round : kerekítés
szam9 :: Int
szam9 = round 10.5

-- ceiling:  mindig a nagyobb egész számot adja vissza
-- floor:    mindig a kisebb egész számot adja vissza

szam10 :: Int
szam10 = ceiling 10.1

-- (Int -> Double) konverzió: "fromIntegral"

double5 :: Double
double5 = fromIntegral 10

-- fromIntegral: sok helyen úgy érdemes használni, hogy megadjuk helyben,
-- hogy mire szeretnénk konvertálni
double6 = (fromIntegral 10 :: Double)


-- Függvények
------------------------------------------------------------

-- függvények típusa: ->

-- függvénydefiníció 1: egyenlőség bal oldalán kisbetűs
--                      változónév
fn1 :: Bool -> Bool
fn1 x = x || x

-- fv. alkalmazás: fn1 kifejezés
-- a kettő nem ugyanaz a kifejezés:
--   fn1 (True || True)
--   fn1 True || True       -- zárójelezés: (fn1 True) || True

fn2 :: Int -> Bool
fn2 x = x == 10

fn3 :: Int -> Int
fn3 x = x + 10

-- több bemenetes függvények
fn4 :: Int -> Int -> Int
fn4 x y = x + y * 100

-- alkalmazás: fn4 kifejezés1 kifejezés2

szam11 = fn4 10 (100 + 400) -- típus egyértelmű
      -- fn4(10, 100+400)

-- if-then-else kifejezések:
fn5 :: Bool -> Int
fn5 x = if x then 0 else 1
      -- if   után: Bool kifejezés
      -- then után: akármilyen típusú kifejezés
      -- else után: ugyanolyan típusú kifejezés, mint then után

      -- "if x then a else b" értéke "a", ha "x==True", és "b", ha
      -- "x==False"


-- másik jelölés függvény definiálására (lambda kifejezések)
------------------------------------------------------------

-- matematikában:
--     f : ℕ → ℕ
--     f = x ↦ x + x

fn5 :: Int -> Int   -- \x -> kifejezés
fn5 = \x -> x + x   -- neve: lambda kifejezés
                    -- \ kiejtése: "lambda"
                    -- anonim függvény (akárhova írhatod mint kifejezést, nem kell nevet adni)

fn6 :: Int -> Int -> Int
fn6 = \x y -> x + y * 10

-- példa "anonim" függvényalkalmazásra
szam12 :: Int
szam12 = (\x -> x + 10) 5   -- eredmény: 15
-- itt a "(\x -> x + 10)" egy (Int -> Int) függvény jelölése, és rögtön alkalmazzuk ezt a függvényt
-- 5-re.


-- operátorok függvénnyé alakítása zárójellel
------------------------------------------------------------

-- Ha egy operátort zárójelbe rakunk, akkor úgy viselkedik, mint egy függvény, és
-- úgy is kell alkalmazni

-- példák:
logikai :: Bool
logikai = (&&) True False

szam10 :: Int
szam10 = (+) 10 20

-- ghci-ben lekérdezhetjük így egy operátor típusát, :t-vel.
--   Prelude> :t (&&)
--   (&&) :: Bool -> Bool -> Bool

-- Szöveg típus: String
------------------------------------------------------------

str1 :: String
str1 = "kutya"

-- String műveletek:
--  két String összefűzése: ++         (String -> String -> String)
--  hossza:                 length     (String -> Int)
--  megfordítás:            reverse    (String -> String)

str2 :: String
str2 = "kutya" ++ "!" -- "kutya!"

len :: Int
len = length str2


-- Hoogle: https://www.haskell.org/hoogle/
------------------------------------------------------------
-- itt lehet keresni név vagy típus alapján függvényekre és dokumentációra.
-- default definíciók, amik mindig betöltödnek: Prelude-ben vannak
-- érdemes: azokat nézni, amelyek a Prelude-ben vannak definiálva

-- Prelude: default műveletek és típusok ghci indítás után rögtön elérhetők
