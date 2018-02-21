-- Copyright 2018 Christoph Charles - MIT License, see LICENSE.MIT

module Simplify
    (simplify)
where

import Expr

simplify :: (Floating a, Eq a, Eq b) => Expr a b -> Expr a b
simplify (Sum (Const a) (Const b)) = Const (a+b)
simplify (Prod (Const a) (Const b)) = Const (a*b)
simplify (Exp (Const a) (Const b)) = Const (a**b)
simplify (Log (Const a)) = Const (log a)
simplify (Cos (Const a)) = Const (cos a)
simplify (Sin (Const a)) = Const (sin a)
simplify (Neg (Const a)) = Const (negate a)
simplify (Inv (Const a)) = Const (1/a)

simplify (Sum (Const 0) a) = simplify a
simplify (Sum a (Const 0)) = simplify a
simplify (Prod (Const 0) a) = Const 0
simplify (Prod a (Const 0)) = Const 0
simplify (Prod (Const 1) a) = simplify a
simplify (Prod a (Const 1)) = simplify a
simplify (Prod (Const a) (Prod (Const b) c)) = Prod (Const $ a*b) (simplify c)

simplify (Sum a b) | a== b = 2 * simplify a
                   | otherwise = simplify a + simplify b
simplify (Prod a b) = simplify a * simplify b
simplify (Exp a b) = Exp (simplify a) (simplify b)
simplify (Log a) = Log (simplify a)
simplify (Cos a) = Cos (simplify a)
simplify (Sin a) = Sin (simplify a)
simplify (Neg a) = Neg (simplify a)
simplify (Inv a) = Inv (simplify a)
              
simplify a = a

