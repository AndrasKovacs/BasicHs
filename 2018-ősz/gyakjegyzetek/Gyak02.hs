{-
    Házi feladatok beadása: bead.inf.elte.hu
      - felhasználónév, jelszó: ugyanaz, mint a laborgépeknél
      - saját csoportot felvenni
      - házi feladatoknál a megoldás mindig egy Haskell file, amit bemásolunk
        a "megoldás" dobozba
      - akárhány verziót be lehet adni határidőig
      - beadás után kb. fél perccel látható, hogy a megoldás átment-e a teszteken
      - csak típushelyes megoldás fogadható el (azaz olyan, ami hiba nélkül betölthető
           ghci-ben)

    lambda.inf.elte.hu: régi tárgyi honlap. A követelmény NEM aktuális, vannak viszont
    interaktív jegyzetek "Kezdő Haskell" oldalon, ezek nem 100%-ban követik a mostani
    anyagot, de nagy az átfedés, és hasznos lehet ezt is nézni.
-}

-- Első házi megjegyzések
------------------------------------------------------------


-- Függvények egyenlősége: egyenlő bemenetre egyenlő kimenet.
-- Összes (Bool -> Bool) függvény:

f1 :: Bool -> Bool
f1 x = x       -- identitásfüggvény

f2 :: Bool -> Bool
f2 x = not x   -- negáció

f3 :: Bool -> Bool
f3 x = True    -- konstans True

f4 :: Bool -> Bool
f4 x = False   -- konstans False

-- Másképpen:
-- f x = if x then ? else ?  -- ?-ek helyére felsorolni
--                           -- a 4 lehetőséget (igazságtábla)


-- Továbbá: x == True ugyanaz, mint x.
-- Tehát, ne írjuk azt, hogy "if x == True then y else z", mivel
-- az ugyanaz, mint "if x then y else z"


-- Operátorok vs. függvénynevek. Zárójelezés.
------------------------------------------------------------

-- példa operátor szimbólumra: +, *, &&, ||
-- példa függvényre (nem operátor): div, not

-- Akármilyen definíciót megadhatunk operátorként, vagy nevesített függvényként.
-- Operátor: ha műveleti szimbólumokból áll a neve.
-- Neves függvény: ha kisbetűvel kezdődik a neve.

-- Példa: operátor definiálása (műveleti szimbólumokból áll)
(***) :: Int -> Int -> Int
(***) x y = x * y

-- ezután megadjuk az operátor zárójelezését (jobb/bal) és a kötés erősségét
--   (hogy milyen sorrendben zárójelezünk)

-- Egyszerre csak egy zárójelezést adhatunk meg (a két másik sort ki kell kommentezni)
infixl 7 ***    -- (balra zárójelez, 7-es erősséggel)
-- infix  4 ***    -- (semerre sem zárójelez, 4-es erősséggel)
-- infixr 8 ***    -- (jobbra zárójelez, 7-es erősséggel)

-- Jobb/bal asszociativitás jelentése:
-- ha pl. *** balra zárójelez, akkor (x ** y ** z) azt jelenti, hogy ((x ** y) ** z)
-- ha jobbra, akkor (x ** y ** z) azt jelenti, hogy (x ** (y ** z))
-- ha semerre, akkor (x ** y ** z) hibás kifejezés, mivel nem egyértelmű.


-- lekérdezni ghci-ben operátor zárójelezését:
-- példa:  :i (+)
-- ghci-ben általában:  :i (név vagy (operátor))

-- Ha valamilyen ismeretlen operátort látunk, akkor érdemes ":i"-vel lekérdezni a
-- zárójelezést


-- Függvény és operátor forma közötti váltás
------------------------------------------------------------

-- Operátorból függvény forma képzése: zárójelbe teszünk bármilyen operátort.
-- példa: +-t függvényként használjuk (+) alakban:
pl :: Int
pl = (+) 10 20

-- Függvényból operátor képzése: backtick (magyar billentyűn: AltGr+7)
-- példa:
pl2 :: Int
pl2 = 10 `div` 3

-- Megmondhatom, hogy egy függvénynév operátoros
-- formájának mi legyen a zárójelezése.
add :: Int -> Int -> Int
add x y = x + y
infixl 6 `add`



-- N-esek (tuple) és mintaaillesztés
------------------------------------------------------------

-- angolul: tuple (n-tuple, n-esek, n-komponensű pár)

-- példák:
p1 :: (Int, Int)      -- pár típus
p1 = (10, 20)         -- pár érték

p2 :: (Bool, Bool, Int)  -- hármasok típusa, két Bool, egy Int
p2 = (True, False, 10)

p3 :: ((Bool -> Bool), Int) -- Bool -> Bool függvény és Int párja
p3 = ((\x -> x) , 10)       -- (->) erősebben köt, mint (,)
                            -- típusban és lambdában is

f5 :: Bool -> (Bool, Int)   -- függvény, ami párt ad vissza
f5 = \x -> (x, 10)

-- mintaillesztéses függvény
f6 :: (Bool, Bool) -> Bool  -- függvény, aminek pár a bemenete
f6 (x, y) = x && y          -- példa alkalmazás: f6 (True,True)

f7 :: (Bool, Bool, Int) -> Bool
f7 (x, y, z) = x

-- párok esetén kényelmi függvények vannak: fst, snd
-- fst: kiveszi egy pár első elemét
-- snd: kiveszi a második elemét
-- példa: fst (True, False)

f6b :: (Bool, Bool) -> Bool   -- mintaillesztés nélkül írjuk
f6b x = fst x && snd x        -- első és második komponens
                              -- &&-je

-- fst, snd csak párra működik (3 vagy nagyobb tuple-re nem)

-- további mód mintaillesztésre: case kifejezés
f7' :: (Bool, Bool) -> Bool
f7' x = case x of (a, b) -> a  -- a és b hivatkozik komponenseire

f8 :: (Bool, Bool) -> Bool
f8 x = case x of    -- a case utáni minták
  (a, b) -> a       -- be legyenek húzva

{-
alábbi hibás:
f8 x = case x of
(a, b) -> a
-}

-- case akárhol alkalmazható
f9 :: (Bool, Int) -> (Bool, Int)
f9 x = (case x of (a, _) -> a, 100)
   -- figyelem: a mintaillesztés (->) is erősebben köt, mint
   -- a (,)

   -- egyszerűbben a definíció:
   -- (fst x, 100)

-- függvényparamétert, vagy mintaillesztésben paramétert
-- később nem használunk, akkor írhatunk név helyett csak
-- egy _ -t.

-- példa:
constTrue :: Bool -> Bool   -- nem használja a Bool paramétert
constTrue _ = True

-- _ olvashatóbbá teszi a definíciót,
-- kommunikáljuk az olvasó felé, hogy valamit nem használunk
constFun :: (Bool, Bool) -> Bool
constFun (_, b) = not b    -- negálja a második komponenst
                           -- és visszaadja

-- Mintaillesztés majdnem mindenen működik.
-- Bool-on:
not' :: Bool -> Bool
not' True  = False
not' False = True

-- esetszétválasztó függvény
-- az eseteket fentről lefelé vizsgálja sorban

-- (megjegyzés: a fun' elnevezés azt jelzi, hogy a fun-t újradefiniáljuk kissé másként)
-- logikai és definíciója mintaillesztéses esetválasztással
and' :: Bool -> Bool -> Bool
and' True  y = y
and' False _ = False

-- logikai vagy
or' :: Bool -> Bool -> Bool
or' False y = y
or' _     _ = True

and'' :: Bool -> Bool -> Bool
and'' True y = y
and'' _ _ = False   -- itt már tudjuk, hogy az első input
                    -- nem lehet True

                    -- föntről lefelé sorban vizsgáljuk
                    -- a mintákat, az első illeszkedő esetnél
                    -- visszaadjuk az eredményt

-- összetett mintaillesztés
f10 :: (Bool, Int) -> Int
f10 (True, _) = 10    -- vizsgálja az első komponenst
f10 (_   , _) = 20


f10' :: (Bool, Int) -> Int
f10' x = if fst x then 10 else 20
  -- ugyanaz a függvény, mint f10


-- mintaillesztés egymásba ágyazott párokon
f11 :: ((Int, Int), Int) -> Int
f11 ((x, y), z) = x + y + z


-- Int mintaillesztés: csak konkrét számokra tudunk illeszteni
f12 :: Int -> Int
f12 10 = 20
f12 20 = 40
f12 _  = 0     -- (minden egyéb eset)





-- Polimorf függvények
--------------------------------------------------------------------------------

swapIntInt :: (Int, Int) -> (Int, Int)  -- megcseréli az elemeket
swapIntInt (x, y) = (y, x)

-- végtelen sok típus van, amire swap függvényt írhatnánk.
-- pl: (Bool, Bool) -> (Bool, Bool)
--     (Bool, Int)  -> (Int, Bool)
--     ((Bool, Int), (Bool, Int)) -> ((Bool, Int), (Bool, Int))
--     stb...

-- szeretnénk swap-et minden típusra egyszerre megírni.



-- swap definiálása egyszerre az összes típuson
swap :: (a, a) -> (a, a)  -- kisbetűs név típusban: tetszőleges típus
                          -- olvasat: legyen swap típusa (a, a) -> (a, a)
                          --          ahol "a" tetszőleges típus
swap (x, y) = (y, x)

swap' :: (a, b) -> (b, a)  -- általánosabb típus. Veszünk két "a" és "b" tetszőleges típust,
                           -- és megcseréljük őket a párban.
swap' (x, y) = (y, x)


-- megjegyzés: ha elhagyjuk a típusdeklarációt,
-- akkor Haskell automatikusan kikövetkezteti a legáltalánossabb típust
-- Példa:
swap'' (x, y) = (y, x)   -- kikövetkeztetett típus: swap'' :: (a, b) -> (b, a)


-- identitásfüggvény
id' :: a -> a     -- tetszőleges "a" típusra (a -> a) függvény
id' x = x

const' :: a -> b -> a    -- konstans függvény
const' x y = x

-- függvénykompozíció
-- kompozíció matematikában: (f ∘ g)(x) = f(g(x))
-- (f . g) x = f (g x)

compose :: (b -> c) -> (a -> b) -> a -> c
compose f g x = f (g x)


-- függvény, ami kap egy függvényt inputként, és egy értéket, és az eredmény
-- a függvény alkalmazása az értékre
apply :: (a -> b) -> a -> b
apply f x = f x   -- tudjuk: (f :: a -> b)
                  --         (x :: a)
                  -- tehát: f x :: b


-- Curry-zés (több argumentumos függvények reprezentálása egymásba ágyazott függvénnyel)
------------------------------------------------------------

-- jegyzet: TODO

add :: Int -> Int -> Int      -- add :: Int -> (Int -> Int)
add x y = x + y

-- add :: Int -> Int -> Int
-- add 0 :: Int -> Int
-- add 1 10 :: Int

add3 :: Int -> Int -> Int -> Int -- Int -> (Int -> (Int -> Int))
add3 x y z = x + y + z

add3' :: (Int, Int, Int) -> Int
add3' (x, y, z) = x + y + z

-- gyakorlati jelentősége: nem muszáj minden inputot megadni, ha
-- kevesebbet adunk meg, akkor olyan függvényt kapunk, ami a "hiányzó"
-- inputokat várja
add' :: Int -> Int -> Int
add' = add

add'' :: Int -> Int -> Int
add'' = \x y -> x + y   -- több argumentumos lambda rövidítése annak, hogy:
                        -- \x -> \y -> x + y
