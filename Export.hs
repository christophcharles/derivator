-- Copyright 2018 Christoph Charles - MIT License, see LICENSE.MIT

module Export
    (Mathematica(..),Sympy(..))
where

class Mathematica a where
  mathExport :: a -> String

class Sympy a where
  symExport :: a -> String
