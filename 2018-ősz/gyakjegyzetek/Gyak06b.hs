{-
Elméleti + gyakorlati

- elmélet:  - feleletválasztós (kb 20 kérdés)
            - 40% pont
            - (+ elõadás diából kérdés) (kör-email-ben)

- gyakorlat:
            - 2 óra, gépes (házi jeleggű + hosszabb feladatok)
                           (hosszabb feladatok utolsó 2 gyakon)
            - 60% pont

mit lehet vizsgán használni:
  - lambda.inf.elte.hu
  - itt lesz elérhetõ: 1-2 oldal szintaxis cheat sheet
  - mást nem lehet használni
  - (elméleti részen semmit nem lehet használni)
-}

-- adattípusok definiálása
------------------------------------------------------------

-- korábban látott típusok: függvények, tuple-ök, Bool, Int, Double, listák

-- beépített típusok: függvények, Int, Double
-- listák, párok: újra tudjuk definiálni

-- Bool újradeifinálása:
data Bool' = True' | False'
  deriving (Eq, Show)

-- Bool'         : típus neve amit definiálunk
--                 (típus konstruktor)
-- True', False' : adat konstruktorok
--                 lehetséges módok, amivel Bool'
--                 értéket megadhatunk

-- deriving (Eq, Show):
--  automatikusan - Eq:  létrehoz (==) definíciót Bool'-ra
--                - Sub: tudunk ghci-ben nyomtatni értékeket


not' :: Bool' -> Bool'
not' True'  = False'
not' False' = True'

-- felsorolás (enumeráció) típus: véges számú konstruktor felsorolásával megadtható
data Direction = North | East | West | South
  deriving (Eq, Show)

d1 :: Direction
d1 = North

turnBack :: Direction -> Direction
turnBack North = South
turnBack East  = West
turnBack West  = East
turnBack South = North


{-
data definíció szintaxisa: data után nagybetűs típus név = után
behúzva az adat konstruktorok, |-al elválasztva

Másik formázás:

data Direction =
    North
  | East
  | West
  | South
  deriving (Eq, Show)
-}

-- Konstruktorok mindig nagybetűvel kezdõdnek
-- Bármilyen konstruktorhoz adhatok adatmezõt

-- Int-ek párja újradefiniálva:
data IntPair = MkIntPair Int Int
  deriving (Eq, Show)

-- függvény:    kisbetűs, műveletet elvégez
-- konstruktor: nagybetűs, csak adatot tárol, mintát lehet
--              rajta illeszteni

p1 :: IntPair
p1 = MkIntPair 100 200

swapIntPair :: IntPair -> IntPair
swapIntPair (MkIntPair x y) = MkIntPair y x

data MyTuple = MkMyTuple Int Int String
  deriving (Eq, Show)

tup1 :: MyTuple
tup1 = MkMyTuple 10 20 "foo"

-- felsorolás típus
data Size = Small | Medium | Large
  deriving (Eq, Show)

data Animal = Cat Size | Dog Size | Horse Size
  deriving (Eq, Show)

-- Cat   :: Size -> Animal
-- Dog   :: Size -> Animal
-- Horse :: Size -> Animal

smallCat :: Animal
smallCat = Cat Small

mediumDog :: Animal
mediumDog = Dog Small

sizeOf :: Animal -> Size
sizeOf (Cat s)   = s
sizeOf (Dog s)   = s
sizeOf (Horse s) = s

-- polimorf adattípus
------------------------------------------------------------

-- pl: tetszõleges típusok párja, újradefiniálva

data Pair a b = MkPair a b
  deriving (Eq, Show)

-- (Pair a b) típus lesz tetszõleges "a" és "b"-re
-- pl: Pair Int Int   egy típus lesz.

pair1 :: Pair Int Int
pair1 = MkPair 100 200

pair2 :: Pair Int Bool
pair2 = MkPair 100 True

-- szintaxis: típusnév után felsorolunk akárhány
-- kisbetűs típusváltozót, és az adatkonstruktorok
-- mezõinél hivatkozhatunk ezekre a típusokra

data Mixed a = MkMixed1 a a | MkMixed2 a Int
  deriving (Eq, Show)

mixed1 :: Mixed String
mixed1 = MkMixed1 "aaa" "bbb"

mixed2 :: Mixed Bool
mixed2 = MkMixed2 True 1000

-- általános jelenség: polimorf adattípusnak polimorf
-- típusú konstruktora

-- pl: MkPair :: a -> b -> Pair a b
-- emlékezzünk: (,) :: a -> b -> (a, b)

-- (a, b) jelölést nem tudunk magunk definiálni,
-- de egyébként (Pair a b) pontosan úgy viselkedik,
-- mint a beépített (a, b) típus.

swap :: Pair a b -> Pair b a
swap (MkPair x y) = MkPair y x


-- Standard adattípus példák
------------------------------------------------------------

{-
data Maybe a = Just a | Nothing

(Maybe a) érték lehet, hogy tartalmaz "a" típusú értéket,
de nem biztos.

Használat: hibakezelésre
           (legegyszerűbb és legbutább módja hibakezelésnek
            Haskell-ben)
-}

-- head :: [a] -> a   (hibát dob üres listára)

-- safeHead soha nem dob hibát
safeHead :: [a] -> Maybe a
safeHead []     = Nothing
safeHead (x:xs) = Just x
   -- cél típusa :: Maybe a
   -- x :: a
   -- tehát (Just x :: Maybe a)

-- tail :: [a] -> [a]
safeTail :: [a] -> Maybe [a]
safeTail []     = Nothing
safeTail (_:xs) = Just xs

-- Maybe elõnye: már a típusból látszik a hiba lehetõsége,
-- és a hibát a programon belül tudjuk (illetve: szükséges)
-- kezelni

-- Either
------------------------------------------------------------

{-
data Either a b = Left a | Right b

Tehát: (Either a b) érték vagy "a" értéket, vagy pedig
                    "b" értéket tartalmaz

Szintén szoktuk hibakezelésre alkamazni.
Szokás szerint (Either a b)-ban az "a" típus
mond valamit egy hibáról, és a Left konstruktor
reprezentál hibás esetet

-}

safeHead' :: [a] -> Either String a
safeHead' []     = Left "error: empty list"
safeHead' (x:xs) = Right x

safeTail' :: [a] -> Either String [a]
safeTail' []     = Left "error: empty list"
safeTail' (x:xs) = Right xs


-- Típus szinonímák
------------------------------------------------------------

-- új név létrehozása, ami csak valamilyen létezõ típusra
-- hivatkozik
-- A cél csak rövidítés, vagy pedig olvashatóság javítása

-- Ha pl. valahol Double-et úgy használjuk, hogy távolságot reprezentál,
-- akkor a Double helyett Distance-ot használva ezt a használatot dokumentáljuk
type Distance = Double

distanceFun :: Distance -> Distance   -- típusban a szinonímára hivatkozunk
distanceFun x = x + 131212312

type Error a = Either String a
-- azt suggallom, hogy az (Either String a)-t szeretném
-- úgy használni, hogy valamilyen hibát reprezentálok vele

-- pusztán rövidítésre használható szintén:
type BFunList = [Bool -> Bool -> Bool]


-- Lista definiálása
------------------------------------------------------------

-- listára [a] jelölést nem tudjuk újradefiniálni,
-- de tudunk olyan lista definíciót adni, ami pontosan
-- úgy viselkedik, mint a beépített lista.

-- ((:) operátor kiejtése általában "cons")
data List a = Empty | Cons a (List a)
  deriving (Eq, Show)

-- List: rekurzív adattípus
-- akkor rekurzív egy típus, ha hivatkozunk arra típusra
-- egy konstruktorban, amit éppen definiálunk

-- rerkurzív adattípuson rekurzív függvényeket definiálunk
-- leggyakrabban


-- (Ez a list definíció más nyelvekben: láncolt lista)
-- (C-ben: láncolt lista (vagy üres vagy nemüres))
-- Nem ugyanaz, mint a tömb
--   tömb:  egymás mellett memóriában az elemek
--   lista: hivatkozások láncolása

--  tömb: indexelés gyors, beszúrás, törlés, elé szúrás
--        lassú
--  lista: indexelés lassú, elé szúrás gyors



list1 :: List Int
list1 = Empty    -- []

list2 :: List Int
list2 = Cons 10 Empty  -- (10 : [])

list3 :: List Int
list3 = Cons 10 (Cons 20 (Cons 30 Empty)) --(10:20:30:[])

length' :: List a -> Int
length' Empty       = 0
length' (Cons x xs) = 1 + length' xs

-- pl: length' list3 == 3

-- (megjegyzés: konstruktor nevek csak egyszer definiálhatók
--  pont úgy, mint függvénynevek)

-- adatkonstruktor is definiálható operátorral
-- megszorítás: mindig ":"-al kezdõdik a konstruktor
-- operátor

data List' a = Empty' | (:>) a (List' a)
  deriving (Eq, Show)
infixr 5 :>

list3' :: List' Int
list3' = 10 :> 20 :> 20 :> 30 :> 40 :> Empty'
      -- 10 :  20 :  20  : 30 :  40 :  []

-- (:) :: a -> [a] -> [a]
-- (:) is csak egy konstruktor, ami csak tárolja
-- az adatot

-- Kétfelé ágazó fa
------------------------------------------------------------

-- rekurzív fa adattípus
data Tree = Leaf | Branch Tree Tree
  deriving (Eq, Show)

tree1 :: Tree
tree1 = Leaf

tree2 :: Tree
tree2 = Branch
          (Branch
            Leaf
            Leaf)
          (Branch
            (Branch
              Leaf
              Leaf)
            (Branch
              Leaf
              Leaf))

-- Bináris (kétfelé ágazó) fa, ami adatot tárol a levelekben
------------------------------------------------------------

-- rekurzív, viszont a (Tree' a)-t definiáljuk
data Tree' a = Leaf' a | Branch' (Tree' a) (Tree' a)
  deriving (Eq, Show)

tree1' :: Tree' Int
tree1' = Branch' (Leaf' 1000) (Leaf' 123123)
