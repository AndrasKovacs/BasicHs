
-- Rekurzív adattípus feladatok

-- lista definiálása data-val
data List a = EmptyList | Cons a (List a)
  deriving (Eq, Show)

-- List a      megfelel  [a]
-- EmptyList   megfelel  []
-- Cons x xs   megfelel  (x:xs)

-- Fa típus, kétfelé ágazik, leveleknél adatot tárolunk
data Tree a = Branch (Tree a) (Tree a) | Leaf a | EmptyLeaf
  deriving (Eq, Show)

tree1 :: Tree Int
tree1 = Branch (Leaf 10) (Leaf 20)

tree2 :: Tree Int
tree2 = Branch (Branch (Leaf 0) EmptyLeaf) EmptyLeaf

-- számoljuk meg a Leaf-eket egy fában
-- mintaillesztés Tree konstruktorain
numLeaves :: Tree a -> Int
numLeaves (Leaf _)            = 1
numLeaves EmptyLeaf           = 0
numLeaves (Branch left right) = numLeaves left + numLeaves right
   -- (általános jelenség: ha van N darab rekurzív mezõ egy konstruktorban,
   --  akkor N darab rekurzív hívásra van szükség egy függvény definícióban)

-- (feladat: adjuk vissza Tree-ben az összes listaelemet
--  mindegy, hogy milyen alakú fában)
listToTree :: [a] -> Tree a
listToTree []     = EmptyLeaf
listToTree (x:xs) = Branch (Leaf x) (listToTree xs)


treeToList :: Tree a -> [a]
treeToList EmptyLeaf      = []
treeToList (Leaf x)       = [x]
treeToList (Branch t1 t2) = treeToList t1 ++ treeToList t2

-- kiértékelés példák:

-- treeToList (Branch (Leaf 10) (Leaf 10))
-- treeToList (Leaf 10) ++ treeToList (Leaf 10)
-- [10] ++ [10]
-- [10, 10]

-- treeToList (Branch (Leaf 0)(Branch (Leaf 1) (Leaf 2))
-- treeToList (Leaf 0) ++ treeToList (Branch (Leaf 1) (Leaf 2))
-- [0] ++ (treeToList (Leaf 1) ++ treeToList (Leaf 2))
-- [0] ++ ([1] ++ [2])
-- [0, 1, 2]


-- (feladat: alkalmazzunk egy függvényt minden Leaf elemein)
mapTree :: (a -> b) -> Tree a -> Tree b
mapTree f EmptyLeaf      = EmptyLeaf
mapTree f (Leaf x)       = Leaf (f x)
mapTree f (Branch t1 t2) = Branch (mapTree f t1) (mapTree f t2)

-- példa: mapTree (\x -> x + 10) (Branch (Leaf 0) (Leaf 1))
--     == Branch (Leaf 10) (Leaf 11)

-- map :: (a -> b) -> [a] -> [b]
-- map ((+) 10) [1, 2, 3] == [11, 12, 13]
