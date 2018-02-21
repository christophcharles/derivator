-- Copyright 2018 Christoph Charles - MIT License, see LICENSE.MIT

module Diff
    (Diff(..)
    ,diff)
where

import Expr

class Diff a where
  d :: Num(b) => a -> a -> Expr b a

diff :: (Eq a, Eq b, Floating a, Diff b) => Expr a b -> Expr a b -> Expr a b
diff (Const a) (Symbol z)   = (Const 0)
diff (Symbol a) (Symbol z)  = d a z
diff (Sum a b) (Symbol z)   = (diff a (Symbol z)) + (diff b (Symbol z))
diff (Prod a b) (Symbol z)  = (diff a (Symbol z)) * b + a * (diff b (Symbol z))
diff (Exp E a) (Symbol z)   = (diff a (Symbol z)) * (exp a)
diff (Exp a b) (Symbol z)   = diff (Exp E (b * (log a))) (Symbol z)
diff (Log a) (Symbol z)     = (diff a (Symbol z)) * a
diff (Cos a) (Symbol z)     = (diff a (Symbol z)) * (Neg $ Sin a)
diff (Sin a) (Symbol z)     = (diff a (Symbol z)) * (Cos a)
diff (Neg a) (Symbol z)     = Neg (diff a (Symbol z))
diff (Inv a) (Symbol z)     = Neg $ (diff a (Symbol z)) / (a * a)
diff E (Symbol z)           = (Const 0)
diff a b                    = error "Differentiation must be done with respect to a symbol"
