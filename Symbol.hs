-- Copyright 2018 Christoph Charles - MIT License, see LICENSE.MIT

module Symbol
    (Sym(..))
where

import Export
import Expr
import Diff

data Sym = Name String deriving Eq

instance Show Sym where
  show (Name a) = a

instance Mathematica Sym where
  mathExport (Name a) = "("++a++")"

instance Diff Sym where
  d x y | x == y = (Const 1)
        | otherwise = (Const 0)

