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
