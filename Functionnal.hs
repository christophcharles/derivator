-- Copyright 2018 Christoph Charles - MIT License, see LICENSE.MIT

module Functionnal
    (Functionnal(..))
where

import Export
import Expr
import Diff
import Symbol

data Functionnal a b = Delta (Expr a Sym)
                     | Var b (Expr a Sym)
                     | Int (Expr a (Functionnal a b)) (Expr a Sym)
                     deriving Eq

instance (Show a, Show b) => Show (Functionnal a b) where
  show (Delta a) = "\\delta \\left(" ++ (show a) ++ "\\right)"
  show (Var a b) = show a ++ "\\left(" ++ (show b) ++ "\\right)"
  show (Int a b) = "\\int \\left("++ (show a) ++ "\\right) \\mathrm{d}(" ++ show b ++ ")"

instance (Show a, Mathematica b) => Mathematica (Functionnal a b) where
  mathExport (Delta a) = "( DiracDelta[(" ++ (mathExport a) ++ ")] )"
  mathExport (Var a b) = "(" ++ mathExport a ++ "[ (" ++ (mathExport b) ++ ") ] )"
  mathExport (Int a b) = "( Integrate[ ("++ (mathExport a) ++ "), (" ++ mathExport b ++ ") ] )"

instance (Num a, Eq a, Floating a, Eq b) => Diff (Functionnal a b) where
  d (Var a b) (Var c d) | a == c = Symbol $ Delta $ b - d
                        | otherwise = (Const 0)
  d (Int a b) c = Symbol $ Int (diff a (Symbol c)) b
  d x y = (Const 0)


