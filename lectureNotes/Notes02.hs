
-- parametrikus polimorf függvény
-- ad-hoc polimorf (NEM AZ ANYAG RÉSZE): típusosztályok
-- a, b, c  szám :  a^2 + b^2 = c^2

-- Függvénydefiníció listákon
------------------------------------------------------------

-- feladat: jegyzetben szereplő lista függvényeket
-- definiáljuk újra

-- kisbetűs típus: "akármilyen" "generikus"

-- mintaillesztés listán és Int-en

-- lista vizsgálat: üres/nem üres

-- ha a lista üres: a minta []
-- ha a list nemüres: (x:xs)

-- []
-- (_:_)

-- (0:1:2:[]) == [0, 1, 2]
take' :: Int -> [a] -> [a]
take' 0 xs     = []
take' n (x:xs) = x : take' (n - 1) xs
take' n []     = []
