
{-

1. feladat

Írj függvényt, ami visszaadja egy lista második és negyedik
elemét. Feltételezzük, hogy a bemenet lista legalább négy elemet
tartamaz. Példák:


  f1 [0..10]  == (1, 5)
  f1 "macska" == ('m', 'k')


2. feladat

Írj függvényt, ami visszaadja egy lista utolsó előtti elemét. Feltételezzük, hogy a bemenet lista
legalább két elemet tartalmaz. Példák:


  f2 [0..10]  == 9
  f2 "macska" == 'k'


3. feladat

Add meg függvénnyel két Int lista skaláris szorzatát. Feltételezzük, hogy a bemenet listák
ugyanolyan hosszúak. Példák a működésre:


  f3 [1, 2] [1, 2] == 5
  f3 [] [] == 0
  f3 [3, 3] [1, 1] == 6
  f3 [10] [10] = 100


4. feladat

Írj függvényt, ami kitörli egy Int listából a listában minimális elem összes előfordulását.
Feltételezzük, hogy nem üres a bemenet. Példák:


  f4 [1, 6, 7, 1] == [6,7]
  f4 [3, 3, 4] == [4]


5. feladat

Írj egy (f5 :: [Maybe String] -> String) függvényt, ami a bemenő listában levő összes String-et
összefűzi. Példák:

  f5 [Just "macska", Nothing, Just "kutya"] == "macskakutya"
  f5 [Nothing, Nothing, Just ""] == ""
  f5 [Just "zebra", Nothing] == "zebra"


6. feladat

Írj (f6 :: String -> String) függvényt, ami a bemenő String-ben előforduló leghosszab szót adja vissza. A bemenetben szavak alatt azokat a rész-String-eket értjük, amelyek egy vagy több szókezzel vannak egymástól elválasztva. Feltételezzük, hogy legalább egy szó van a bemenetben. Példák:

  f6 "macska majom egér" == "macska"
  f6 "  macska    majom     egér  " == "macska"


7. feladat

Definiálj egy "Day" nevű adattípust, aminek a konstruktorai a hét napjait jelölik. Érdemes "deriving (Eq, Show)"-ot is megadni a definícióhoz.

Definiálj ehhez egy (weekday :: Day -> Bool) függvényt, ami megadja, hogy egy nap hétköznap-e.

Definiálj még egy (nextDay :: Day -> Day) függvényt, ami a sorban következő napot adja meg.

-}
