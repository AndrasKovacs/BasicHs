
{-
Vizsgával kapcsolatban:

Elméleti + gyakorlati rész

Elmélet:
  - 40% pont
  - (+ elõadás diasorból)
  - feletválasztós kérdések (kb. 20 darab)

Gyakorlat:
  - Gépes, 2 óra, 60% pont
  - Mit lehet használni:
    - tárgy honlap (lambda.inf.elte.hu)
    - lesz elérhetõ: cheat sheet (rövid szintaxis összefoglaló)
    - mást nem lehet használni

Vizsga adminisztráció:
  - Neptunban idõpontok láthatók vizsgaidõszak elõtt kb 2 héttel.
  - Neptunban vizsgára jelentkezés.
  - 3+1 vizsgaalkalom szokott lenni

-}

-- Adattípusok
--------------------------------------------------------------------------------

-- Milyen típusokat láttunk eddig: függvény, tuple, Int, Double, Bool, listák

-- függvény: primitív, beépített fogalom
-- viszont: minden más eddig látott típust újra tudunk definiálni.

-- (szintaktikus rövidítéseket listára (pl: [a]) és párra (pl: (a, b))
--  nem tudjuk újradefiniálni)

-- Bool definiálása:

data Bool' = True' | False'
  deriving Show

-- Bool'          : a típus neve
-- True', False'  : a típus lehetséges értékei

-- "deriving Show" : automatikusan létrehoz kódot,
-- amivel ghci-ben ki tudjuk nyomtatni a típus elemeit.
-- Ha van "deriving show", akkor tudunk használni
-- (show :: Bool' -> String) függvényt, ami String-ként
-- megadja az értéket.

-- Bool' pontosan úgy viselkedik, mint Bool.

-- ugyanaz, mint (show :: Bool' -> String)
f1 :: Bool' -> String
f1 True'  = "True'"
f1 False' = "False'"

-- akárhány lehetséges értékat megadhatunk
-- enumeráció: olyan típus, ami megadható véges számú
-- lehetséges értékek felsorolásaként

data Direction = South | North | East | West
  deriving Show

-- mintaillesztés analóg módon Bool-al
turnBack :: Direction -> Direction
turnBack South = North
turnBack North = South
turnBack East  = West
turnBack West  = East

{-
data szintaxisról: azt jegyezzük meg, hogy be kell húzni a megadott
konstruktorokat, és |-el kell elválasztani. Példa alternatív
definícióra:

data Direction
  = North
  | South
  | East
  | West
-}


-- Típus konstruktor: data utáni név, nagybetűs
-- Adat konstruktor: "data Valami =" utáni név,
--   szintén nagybetűvel kezdõdik

-- pl. Direction típuskonstruktor
--     North adatkonstruktor

-- tuple konstruktorok
----------------------------------------

-- (Int, Int) típus újradefiniálása
-- egy konstruktor, viszont az tartalmaz két Int
-- adatmezõt:
data IntPair = Con Int Int

-- IntPair: típus neve
-- Automatikusan elérhetõ Con konstruktor következõ típussal:
-- Con :: Int -> Int -> IntPair
-- (Con x y)    lényegében: x és y Int-ek párja

-- swap
swap :: IntPair -> IntPair
swap (Con x y) = Con y x

-- mintaillesztésnél azokat a mezõket kell feltűntetni
-- amelyeket a data definíciónál megadtunk
-- tehát Con-hoz két Int típusú

{-
(Alternatív data definíció szintaxis,
 fájl elejére azt kell tenni, hogy:
 {-# language GADTs #-})

ekkor:

data IntPair where
  Con :: Int -> Int -> IntPair

data Bool where
  True  :: Bool
  False :: Bool

data Direction where
  North :: Direction
  East  :: Direction
  West  :: Direction
  South :: Direction
-}

-- két lehetséges konstruktor
-- vagy Int pár
-- vagy pedig egy Bool
data IntPairOrBool = Con1 Int Int | Con2 Bool
  deriving Show

-- Con1 :: Int -> Int -> IntPairOrBool
-- Con2 :: Bool -> IntPairOrBool

f2 :: IntPairOrBool -> IntPairOrBool
f2 (Con1 x y) = Con1 (x + 10)(y + 10)
f2 (Con2 x)   = Con2 (not x)  -- x típusa Bool


data Size = Small | Medium | Large
  deriving (Show, Eq, Ord)

-- deriving Eq: egyenlõségvizsgálatot hoz létre
-- típushoz. Lehet használni (==) operátort.

-- deriving Ord: összehasonlítás automatikusan
-- (<), (<=), (>), (>=)
-- (a késõbb írt konstruktor nagyobb)

-- deriving: csak akkor lehet, ha minden
-- data-ban használt típusra szintén van
-- pl: Animal-re deriving (Show, Eq, Ord) azért
-- lehet, mert Size-ra már derive-oltuk ezeket.

-- példa olyan data-ra, ahol Show deriving nincsen.

-- például: függvényekre nincsen Show
-- tehát NoShow-ra sem lehet deriving Show-t adni
data NoShow = MkNoShow (Int -> Int)

-- példa NoShow értékre
-- egy konstruktor, aminek függvény típusú mezõje van
noShow :: NoShow
noShow = MkNoShow (\x -> x + 100)

data Animal = Dog Size | Cat Size | Horse Size
  deriving (Show, Eq, Ord)

-- egyenlõség Size-ra
equalSize :: Size -> Size -> Bool
equalSize Large  Large  = True
equalSize Small  Small  = True
equalSize Medium Medium = True
equalSize _      _      = False



-- példák Animal értékekre
myDog :: Animal
myDog = Dog Small

animal1 :: Animal
animal1 = Horse Large

-- három állatkonstruktor
-- mindegyiknek egy adatmezõje van, ami Size típusú

-- megadja egy állat méretét
getSize :: Animal -> Size
getSize (Dog s)   = s
getSize (Cat s)   = s
getSize (Horse s) = s

-- Definiáljuk újra a pár típust
----------------------------------------

-- IntPair-ban a mezõk típusa rögzített
-- tetszõleges típusok párjai:
-- Ha "a", "b" típusok, akkor "Pair a b" szintén típus

-- egy konstruktor, a és b típusú mezõkkel "polimorf" adattípus,
-- hasonlóképpen mint a polimorf függvények Típusnév után felsorolunk
-- n darab kisbetűs típusnevet, amelyekre az adatkonstruktoroknál
-- hivatkozhatunk.

data Pair a b = MkPair a b
  deriving (Eq, Show, Ord)
  -- (okos dolgokat derive-ol: minden felhasználja
  -- a mezõkre vonatkozó Eq, Show, Ord-ot)
  -- (pl. MkPair (Int -> Int) Bool    esetén nincs Show)

-- példák
pair1 :: Pair Int Bool
pair1 = MkPair 0 True

swapPair :: Pair a b -> Pair b a
swapPair (MkPair x y) = MkPair y x


-- konstruktor vs függvény

-- függvény: - valamilyen műveletet elvégez
--           - kisbetűs

-- konstruktor:
--           - csak adatot tárol
--           - nagybetűs
--           - van rá mintaillesztés

-- Maybe
------------------------------------------------------------

{-
standard adattípus: Maybe

data Maybe a = Just a | Nothing
  deriving (Eq, Show, Ord)

(Mabye a) típusú érték: lehet hogy tartalmaz "a" típusú mezõt, de nem
biztos.

Maybe típust általában hibakezelésre használjuk.

-}

maybeInt :: Maybe Int
maybeInt = Just 4

maybeInt2 :: Maybe Int
maybeInt2 = Nothing

maybeString :: Maybe String
maybeString = Just "foo"

-- korábban: tail :: [a] -> [a]
--           hibát dobott üres listára

-- ehelyett: safeTail soha nem dob hibát, hanem a hibát a Maybe típus
-- Nothing konstruktorával jelzi.
safeTail :: [a] -> Maybe [a]
safeTail []     = Nothing
safeTail (x:xs) = Just xs

safeHead :: [a] -> Maybe a
safeHead []     = Nothing
safeHead (x:xs) = Just x


-- Either
------------------------------------------------------------

{-
standard típus: Either

Either a b értékei: vagy a típusú mezõt tartalmaz
                    vagy b típusú mezõt tartalmaz

data Either a b = Left a | Right b
-}

either1 :: Either Int Int
either1 = Left 0

either2 :: Either Int String
either2 = Right "foo"

-- polimorf érték: a "b" típus bármi lehet, mivel a Left konstruktorból
-- nem derül ki semmi róla.
either3 :: Either Int b
either3 = Left 10

-- hasonlóképpen:
either4 :: Either a Bool
either4 = Right False
-- emélkezzünk, hogy az üres lista szintén polimorf érték, mivel akármilyen
-- elemtípusú listának az értéke ([] :: [a])


-- (Either Int Bool) újradefiniálása:
-- data IntOrBool = AnInt Int | ABool Bool

-- (Maybe Int) újradefiniálása:
-- data MaybeInt = JustInt Int | NoInt

-- Nem szeretnénk ilyen típusokat sokszor újradefiniálni.
-- Polimorf Either és Maybe segítségével ez elkerülhető.

-- példa függvény:
eitherToMaybe :: Either a b -> Maybe a
eitherToMaybe (Left x)  = Just x
eitherToMaybe (Right _) = Nothing
