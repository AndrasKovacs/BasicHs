
-- Feladat: mi a típusa a következő kifejezésnek:
--   map (\x -> (x, x))

-- map :: (a -> b) -> [a] -> [b]
-- map (\x -> (x, x)) :: [?] -> [?]
-- (\x -> (x, x)) :: a -> (a, a)
-- map (\x -> (x, x)) :: [a] -> [(a, a)]

-- Feladat
--------------------------------------------------


-- Feladat:
-- futamhossz: kódolás, dekódolás


encode :: Eq a => [a] -> [(Int, a)]
encode = undefined

decode :: Eq a => [(Int, a)] -> [a]
decode = undefined

-- példa a működésre:
encode "foo" == [(1, 'f'), (2, 'o')]
encode [1, 1, 3, 3, 3] == [(2, 1), (3, 3)]
encode "aabbaa" == [(2, 'a'), (2, 'b'), (2, 'a')]

-- [(Int, a)] :
--    Int: hányszor ismétlődik egy elem (egymás után)
--    a  : mi az az elem

-- bármely "as" listára: decode (encode as) == as

-- Feladat 2: mélységi gráfbejárás
----------------------------------------

-- (depth first search)
-- input: adjacencia lista
dfs :: [(Int, [Int])] -> Int -> [Int]
dfs = undefined

-- Feladat: van egy irányított gráf [(Int, [Int])]
--   és egy kezdő csúcs: Int
--   output: kezdő csúcsból kiindulva
--           mélységi bejárási sorrendben
--           az innen elérhető csúcs

-- mélységi sorrend: balról jobbra a kiinduló élek listá
-- jában

-- gráf reprezentációja (3db csúcs esetén):
-- [(0, [0, 1, 2]), (1, [2]), (2, [])]

-- első pár komponens: egy csúcs
-- második pár komponens: azon csúcsok listája,
-- ahova él megy a csúcsból

-- dfs [(0, [1]), (1, [])] 0 == [1]
-- dfs [(0, [1]), (1, [0])] 0 == [1, 0]
-- minden csúcsot max egyszer járunk be

-- HÉTFŐN ZH
