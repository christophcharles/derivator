This code is designed to compute basic derivative operations, but flexible enough to handle functionnal derivatives. It can be used to output a LaTeX, Mathematica or SymPy (TODO) expression that can then be further simplified and used. Basic simplification capabilities are built in but they are really really basic. It is possible to assemble the resulting expressions using basic algebraic operations but that's basically it.

The simpliest way to use it is through a haskell interpreter, for instance ghci. In that case, after launching ghci from the source folder, you should get a prompt resembling:
Prelude> 
Enter :
Prelude> :l Interactive.hs
to load all the necessary files. Normally after compiling a few files, ghci should display:
Ok, modules loaded: Diff, Export, Expr, Functionnal, Main, Simplify, Symbol.
*Main> 
or something similar. You are good to go with this new prompt.

In a very SymPy fashion, the first thing you should do is declare the basic variables you are going to use. For instance :
*Main> varX = Symbol (Name "x")
*Main> varY = Symbol (Name "y")
This defines two variables varX and varY that will behave as symbols names "x" and "y". This step is not mandatory, as you are free to introduce constructors inside your expressions, but greatly simplify writing afterwards. These new symbols can now be assembled into expression. For instance:
*Main> expr = 2 * varX + varY

Now comes the tricky part. Let's say, we want to take the functionnal derivative of f(x) with respect to f(y). The result should be a Dirac delta. How do we write that?
Let's first define our two symbols x and y:
*Main> varX = Symbol (Name "x")
*Main> varY = Symbol (Name "y")
Then let's define the functionnal symbol f(x) and f(y):
*Main> fX = Symbol (Var (Name "f") varX)
*Main> fY = Symbol (Var (Name "f") varY)
We can now differentiate:
*Main> res = diff fX fY
To display the result, you can either use the show, which will output a LaTeX expression, or mathExport and symExport which will export a Mathematica and SymPy (TODO) expression respectively.
*Main> res
\delta \left(\left(x + \left(-y\right)\right)\right)
*Main> mathExport res 
"( DiracDelta[(( ((x)) + (( - ((y)) )) ))] )"

The basic idea behing all this is we build expressions out of symbols. What symbols mean here is quite generic. It is something that can be added, substracted put into an exponential and the like. And most notably, they can be derived with respect to the same kind of symbol. Then, we can do two things. Either symbols are directly interpreted as placeholders for variables (as we have done for varX and varY). Or, they can be understood as something more complicated, like a full new functionnal expression.

This solves a few problems at the price of readability. For instance, this is how we write the integral of of f(x):
*Main> integral = Symbol (Int (fX) (varX))
The idea is the integral is something very specific to functionnals and cannot be integrated into a generic expression easily. But, it can be introduced as a symbol that will have expression parts and which implements itself its derivation rules. Therefore, we can compute the derivative with respect to f(y) in the following way:
*Main> res = diff integral fY





