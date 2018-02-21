-- Copyright 2018 Christoph Charles - MIT License, see LICENSE.MIT

module Expr
    (Expr(..))
where

import Export

data Expr a b = Const a
              | Symbol b
              | Sum (Expr a b) (Expr a b)
              | Prod (Expr a b) (Expr a b)
              | Exp (Expr a b) (Expr a b)
              | Log (Expr a b)
              | Cos (Expr a b)
              | Sin (Expr a b)
              | Neg (Expr a b)
              | Inv (Expr a b)
              | E
              deriving(Eq)

instance (Num a) => Num (Expr a b) where
  (+) = Sum
  a - b = Sum a (Neg b)
  (*) = Prod
  negate = Neg
  signum = undefined
  abs = undefined
  fromInteger a = Const (fromInteger a)

instance (Floating a) => Fractional (Expr a b) where
  a / b = Prod a (Inv b)
  fromRational a = Const (fromRational a)

instance (Floating a) => Floating (Expr a b) where
  pi    = Const pi
  exp   = Exp E
  sqrt  = flip Exp (1/2)
  log   = Log
  sin   = Sin
  tan a = Prod (Sin a) (Inv (Cos a))
  cos   = Cos
  (**)  = Exp
  logBase a b = Prod (Log a) (Inv (Log b))
  asin  = undefined
  atan  = undefined
  acos  = undefined
  sinh  = undefined
  tanh  = undefined
  cosh  = undefined
  asinh = undefined
  atanh = undefined
  acosh = undefined

instance (Show a, Show b) => Show (Expr a b) where
  show (Const a)  = show a
  show (Symbol a) = show a
  show (Prod a b) = "\\left(" ++ show a ++ " * " ++ show b ++ "\\right)"
  show (Sum  a b) = "\\left(" ++ show a ++ " + " ++ show b ++ "\\right)"
  show (Neg a)    = "\\left(-" ++ show a ++ "\\right)"
  show (Inv a)    = "\\frac{1}{" ++ show a ++ "}"
  show (Sin a)    = "\\sin\\left(" ++ show a ++ "\\right)"
  show (Cos a)    = "\\cos\\left(" ++ show a ++ "\\right)"
  show (Log a)    = "\\log\\left(" ++show a++ "\\right)"
  show (Exp a b)  = "\\left(" ++ show a ++ "\\right)^{" ++ show b ++ "}"
  show (E) = "\\mathrm{e}"

instance (Show a, Mathematica b) => Mathematica (Expr a b) where
  mathExport (Const a)  = "(" ++ show a ++ ")"
  mathExport (Symbol a) = mathExport a
  mathExport (Prod a b) = "( (" ++ mathExport a ++ ") * (" ++ mathExport b ++ ") )"
  mathExport (Sum  a b) = "( (" ++ mathExport a ++ ") + (" ++ mathExport b ++ ") )"
  mathExport (Neg a)    = "( - (" ++ mathExport a ++ ") )"
  mathExport (Inv a)    = "( 1 / (" ++ mathExport a ++ ") )"
  mathExport (Sin a)    = "(Sin[" ++ mathExport a ++ "] )"
  mathExport (Cos a)    = "(Cos[" ++ mathExport a ++ "] )"
  mathExport (Log a)    = "( Log[" ++ mathExport a++ "] )"
  mathExport (Exp a b)  = "( Exp[ (" ++ mathExport b ++ ") * Log[" ++ mathExport a ++ "] ] )"
  mathExport (E) = "( E )"
