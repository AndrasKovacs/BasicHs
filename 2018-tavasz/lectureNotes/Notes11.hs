
eval :: [(String, Int -> Int)] -> [(String, Int -> Int -> Int)]
     -> [Int] -> [String] -> Int
eval f1 f2 = go where
  go [n]   []       = n
  go stack (op:ops) =
    case (lookup op f1, stack) of
      (Just f, a:stack) -> go (f a:stack) ops
      _      -> case (lookup op f2, stack) of
        (Just f, a:b:stack) -> go (f a b : stack) ops
        _ -> go (read op : stack) ops

unaryOps = [
  ("abs", abs),
  ("inc", (+1)),
  ("dec", (\x -> x - 1))]

binOps = [
  ("+", (+)),
  ("*", (*)),
  ("%", mod),
  ("/", div)]

rpn :: String -> Int
rpn = eval unaryOps binOps [] . words










-- eval :: [Int] -> [String] -> Int
-- eval (a:b:stack) ("+"  :ops) = eval (a + b   : stack) ops
-- eval (a:b:stack) ("*"  :ops) = eval (a * b   : stack) ops
-- eval (a:b:stack) ("%"  :ops) = eval (mod a b : stack) ops
-- eval (a:b:stack) ("/"  :ops) = eval (div a b : stack) ops
-- eval (a:stack)   ("inc":ops) = eval (a + 1   : stack) ops
-- eval (a:stack)   ("dec":ops) = eval (a - 1   : stack) ops
-- eval (a:stack)   ("abs":ops) = eval (abs a   : stack) ops
-- eval stack       (n    :ops) = eval (read n  : stack) ops
-- eval [n]         []          = n

-- rpn :: String -> Int
-- rpn = eval [] . words
