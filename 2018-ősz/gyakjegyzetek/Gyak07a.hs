
-- Adattípusok folyt
--------------------------------------------------------------------------------

-- Felsorolás, polimorf adattípus (paraméteres típus)
-- Felsorolás: Bool, Direction
-- Polimorf: Maybe, Either, tuple típusok

-- Listák újradefiniálása
-- lista jelölést ([], [x, y, z]) nem tudjuk újradefiniálni, egyébként
-- lényegében meg tudunk adni listát saját típusként

-- típust nevezzük List-nek
-- "List a"-ban "a" az elemek típusa
data List a = Empty | Cons a (List a)
  deriving (Eq, Show)

list1 :: List Int
list1 = Empty

list2 :: List Int
list2 = Cons 0 (Cons 10 Empty)
     -- (0 : (10 : []))

-- List rekurzív adattípus
--      rekurzív adattípus: az éppen definiált típus
--        megjelenik valamelyik mezõben

-- Általános jelenség: rekurzív adattípuson rekurzív függvényeket írunk (legtöbbször)

-- mintaillesztés konstruktorokra
length' :: List a -> Int
length' Empty       = 0
length' (Cons x xs) = 1 + length' xs

-- mintailesztés ugyanúgy, mint [a] esetén, csak
-- Empty-re vagy (Cons x xs)-re illesztünk.

list5 :: List Int
list5 = Cons 0 (Cons 1 (Cons 2 (Cons 3 (Cons 4 Empty))))

-- hogyan tűntethetünk el Cons után zárójeleket?

-- 1. ($)-al
list5' :: List Int
list5' = Cons 0 $ Cons 1 $ Cons 2 $ Cons 3 $ Cons 4 Empty
-- (($) operátor csak függvényt alkalmaz, de más zárójelezéssel, mint a rendes függvényalkalmazás)

-- 2. konstruktor is definiálható operátorként (megkötés: csak :-al kezdõdhet)
data List' a = Empty' | (:>) a (List' a)
  deriving (Eq, Show)
infixr 5 :>

list5'' :: List' Int
list5'' = 0 :> 1 :> 2 :> 3 :> 4 :> Empty'

  -- ghci-ben a Show-ból kapott nyomtatás nem a legokosabb:
  -- (:>) 0 ((:>) 1 ((:>) 2 ((:>) 3 ((:>) 4 Empty'))))
  -- Cons 0 (Cons 1 ....)


-- Fák rekurzív típusa
--------------------------------------------------------------------------------

data Tree = Leaf | Branch Tree Tree
  deriving (Eq, Show)

-- miért fa?
tree1 :: Tree
tree1 = Branch Leaf Leaf

tree2 :: Tree
tree2 = Branch
          (Branch
            Leaf
            Leaf)
          (Branch
            Leaf
            Leaf)

tree3 :: Tree
tree3 = Branch
          (Branch
            (Branch
              (Branch
                Leaf
                Leaf)
               Leaf)
            Leaf)
          (Branch
            Leaf
            Leaf)

-- számoljuk meg a Leaf-eket egy fában
treeSize :: Tree -> Int
treeSize Leaf         = 1
treeSize (Branch l r) = treeSize l + treeSize r
  -- mivel két rekurzív részfa van, ezért két rekurzív hívás kell
  -- vessük össze listával: (:) esetén a lista hátralevő része
  --   egy darab rekurzív mező, tehát egy rekurzv hívás kell

-- Fa, ami a leveleknél adatot tárol
data Tree' a = Leaf' a | Branch' (Tree' a) (Tree' a)
  deriving (Eq, Show)

tree1' :: Tree' Int
tree1' = Branch' (Leaf' 10) (Leaf' 10)


-- data-val megadható típusok általában fák
-- (elágazások tetszõlegesek, és minden konstruktor extra adatokkal
--  kiegészíthetõ)

-- fák speciális esete a lista: lista olyan fa, ami egy részfával ágazik, és
-- minden elágazás valamilyen adattal van annotálva

-- önálló feladatmegoldás:

-- data Tree' a = Leaf' a | Branch' (Tree' a) (Tree' a)
--   deriving (Eq, Show)

-- adjuk vissza listában az összes Leaf'-ben
-- tárolt adatot (mintaillesztés Tree' konstruktorokra)
treeToList :: Tree' a -> [a]
treeToList (Leaf' x)     = [x]
treeToList (Branch' x y) = treeToList x ++ treeToList y
  -- mit tudunk csinálni?
  -- x,y szintén fák, rekurzívan fedolgozthatjuk x-et
  -- és y-t

-- kiértékelés példák:

-- treeToList (Branch' (Leaf' 10) (Leaf' 10))
-- treeToList (Leaf' 10) ++ treeToList (Leaf' 10)
-- [10] ++ [10]
-- [10, 10]

-- treeToList (Branch' (Leaf' 0)(Branch' (Leaf' 1) (Leaf' 2))
-- treeToList (Leaf' 0) ++ treeToList (Branch' (Leaf' 1) (Leaf' 2))
-- [0] ++ (treeToList (Leaf' 1) ++ treeToList (Leaf' 2))
-- [0] ++ ([1] ++ [2])
-- [0, 1, 2]

-- adjuk össze az Int-eket a fában
sumTree :: Tree' Int -> Int
sumTree (Leaf' x) = x
sumTree (Branch' l r) = sumTree l + sumTree r

-- listából fát (szabad választás, hogy milyen fában adjuk vissza, viszont az
-- összes a-t adjuk vissza) (feltesszük, hogy input lista nem üres)
listToTree :: [a] -> Tree' a
listToTree []     = undefined
listToTree [x]    = Leaf' x
listToTree (x:xs) = Branch' (Leaf' x) (listToTree xs)
         -- másképpen: Branch' (listToTree xs) (Leaf' x)
         -- (ekkor balra ágazik tovább az eredmény fa)

-- pl: listToTree [1, 2] == Branch' (Leaf' 1) (Leaf' 2)
-- listToTree [1, 2, 3]
--  == Branch' (Leaf' 1) (Branch' (Leaf' 2) (Leaf' 3))

-- Azért tettük fel, hogy az input lista nem üres, mivel a definiált Tree'
-- típusban nincsen üres fa (minden fa legalább egy Leaf'-et tartalmaz, valamely
-- "a" adattal együtt).
