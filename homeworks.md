#### 1

Implementáljuk két lista összefésülését: az output váltakozva
tartalmazza a két input lista elemeit.  A függvény neve legyen
`interleave`, típusa :: `[a] -> [a] -> [a]`.

Példák a működésre:

```haskell
interleave "foo" "bar" == "fboaor"
interleave [1, 2, 3] [5, 4, 3] == [1, 5, 2, 4, 3, 3]
interleave "abc" "abc" == "aabbcc"
```

#### 2

Implementáljunk egy `dropEveryNth :: [a] -> Int -> [a]` függvényt, ami elhagyja minden n-edik elemet az input listából. Pl. a `dropEveryNth xs 2` minden második elemet elhagyja `xs`-ből. Feltételezzük, hogy az `Int` input nagyobb, mint `0`.

Példák a működésre:

```haskell
dropEveryNth [0..10] 2 == [0,2,4,6,8,10]
dropEveryNth [0..10] 3 == [0,1,3,4,6,7,9,10]
dropEveryNth [0..10] 1 == []
dropEveryNth [0..10] 5 == [0,1,2,3,5,6,7,8,10]
```
#### 3

Írj egy `getWords :: String -> [String]` függvényt, ami szavakra bont fel egy input `String`-et. Azaz, az inputban egy vagy több szóközzel elválasztott rész-`String`-ek listáját kell visszaadni. Példák:

```haskell
getWords "foo bar" == ["foo", "bar"]
getWords "  foo  bar  " == ["foo", "bar"]
getWords "" == []
getWords "a b c d e f" == ["a", "b", "c", "d", "e", "f"]
```

Tipp: mintaillesztést csinálhatunk a szóköz karakteren `' '`, vagy `==`-el vizsgálhatjuk karakterek egyenlőségét. 

Figyelem: ne használjuk a standard `words` függvényt.

#### 4

Írjunk egy `composeAll :: [a -> a] -> a -> a` függvényt. Az input `[a -> a]` függvényeket tartalmazó lista, a feladat az összes ebben található függvényt alkalmazni az `a` inputra. A függvényeket jobbról balra alkalmazzuk, pl. `composeAll [f, g, h] x = f (g (h (x))`. Továbbá, `composeAll [] x = x` teljesül. Példák a működésre:

```haskell
composeAll [(+10), (+20), (+30)] 0 == 60
composeAll [(*10), (+20)] 2 == 220
composeAll [] True == True
composeAll [('a':), ('b':), ('c':)] "" == "abc"
```

#### 5

Írjunk egy `groupBy :: (a -> a -> Bool) -> [a] -> [[a]]` függvényt. A függvény szétbontja az input listát output listákra úgy, hogy a `concat`-olt output visszaadja az inputot, továbbá igaz, hogy az `a -> a -> Bool` függvény `True`-t ad minden egymást követő két értékre az output listákban.

Példák a működésre:

```haskell
-- grouBy (==) az egyenlő elemeket csoportosítja
groupBy (==) [0, 0, 1, 1, 2, 2] == [[0, 0], [1, 1], [2, 2]]
groupBy (==) [0, 1, 2] == [[0], [1], [2]]
-- groupBy (<) a szigorú növekvő részlistákat adja vissza
groupBy (<) [0, 1, 2, 1, 2, 3] == [[0,1,2],[1,2,3]]
groupBy (<) [3, 4, 5] == [[3], [4], [5]]

groupBy (>=) [3, 3, 1, 5] == [[3,3,1],[5]]

-- a részlisták, amelynél az egymást követő elemek különbsége 1:
groupBy (\x y -> abs (x - y) == 1) [0, 1, 3, 4] == [[0, 1], [3, 4]]
groupBy (\x y -> abs (x - y) == 1) [1, 2, 3, 2, 1, 10, 11] == [[1,2,3,2,1],[10,11]]
```

Figyelem: bár a `Data.List` modulban található egy standard `groupBy` függvény, annak a viselkedése különböző a jelenlegi feladatban várt megoldástól.

