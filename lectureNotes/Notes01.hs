
foo :: String
foo = "foobar"

foo2 :: String
foo2 = "foo2"

-- :l file.hs     betöltés ghci-ben
-- :r             jelenlegi fájl újratöltése

-- függvényhívás szintaxisa nem a megszokott!

-- operátor köré zárójel: szimpla prefix függvényként
-- alkalmazzuk

-- Int, Bool

number :: Int      -- típusdeklaráció
number = 0         -- definíció

myBool :: Bool     -- típusdeklaráció
myBool = True      -- definíció

-- de: típusdeklaráció nem kötelező

myBool2 = True       -- csak definíció

-- típuskikövetkeztetés van mindenre
-- típusokban sok információ lesz

fun1 :: Bool -> Bool     -- input: Bool, output: Bool
fun1 x = x               -- egyenlőség bal oldalán input

fun2 :: Bool -> Bool
fun2 = \x -> x          -- (\x -> x)

fun3 :: Bool -> Bool -> Bool
fun3 x y = x && y

fun4 :: Bool -> Bool -> Bool
fun4 = \x y -> x && y

-- lokális definíció: (let vagy where)
fun5 :: Bool -> Bool -> Bool
fun5 x y =
  let
    result = x && y
    foo = True
    bar = False
    satobbi = 1000212
  in
    foo

fun6 :: Bool -> (Bool -> Bool)
fun6 x y = foo
  where
    foo = x && y && x
    t1  = 1010
    t2  = 2313123

-- alapból: csak egyparaméreter függvény van
-- viszont: bármikor visszaadhatunk függvényt

g :: Int -> Int -> Int
g x y = x + y

-- megvilágosodtunk a fv. applikáció szintaxisa felől

h :: Int -> Int -> Int -> Int
h = \x y z -> x + y * z + 231321

-- mire jó ez?
-- nagyon sok olyan függvény lesz
add10 :: Int -> Int
add10 = (+) 10

-- Listák
----------------------------------------

l1 :: [Int]      -- Int listák típusa
l1 = [0, 1, 2, 3]

l2 :: [Int]
l2 = []

-- homogén lista típus: minden elemnek ugyanaz
-- a típusa

-- String
----------------------------------------

str1 :: String
str1 = "hello world"

-- Char típus
str2 :: [Char]
str2 = "hello world"

-- Char literál (unicode)
chr1 :: Char
chr1 = 'a'

hello :: [Char]
hello = ['h', 'e', 'l', 'l', 'o']

-- Egyszerű listaműveletek
----------------------------------------

-- konkatenáció (összefűzés) (++)

cat1 :: String
cat1 = "hello" ++ "world"

cat2 :: [Int]
cat2 = [1, 2, 3] ++ [4, 5, 6]

-- első eleme (head)

head1 :: Int
head1 = head [0, 1, 2, 3]

-- indexálás (!!)  (nullától kezdve számozás)

ix1 :: Int
ix1 = [0, 1, 2, 3] !! 0

-- drop: (első n darab elemet elhagyni)
-- take: (első n darab elemet venni)

drop1 :: String
drop1 = drop 5 "hello world"   -- első 5 Char elhagyva

take1 :: String
take1 = take 5 "hello world"   -- első 5 Char megtartva

-- magasabbrendű függvények

-- mappelés
incAll :: [Int] -> [Int]
incAll = map ((+) 1)

constA :: Char -> Char
constA c = 'A'

-- konstans függvény
const' :: Char -> Char -> Char
const' c1 c2 = c1

onlyA :: String -> String
onlyA str = map (const' 'A') str


-- jó gyakorlat típusdeklaráció minden (top-level)
-- definícióhoz

-- ghci: interpreter
-- ghc:  compiler
-- :t   -- kifejezés típusa
-- .hs

{-
ez is komment

-}
