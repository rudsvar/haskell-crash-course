# Installation

The instructions take approximately 20-30 min.

## Quick Guide

1. Install the Haskell Platform.
2. Install Visual Studio Code.
3. Install the VSCode Haskell plugin.
4. Install Stack

## Haskell Platform (Compiler and Build Tools)
The Haskell Platform calls itself “Haskell with batteries included”,
which just means that it includes all the tools you need to get started.
Here is a quick overview of what the different ones are for.
You can get it [here](https://www.haskell.org/platform/).
Most importantly, it includes GHC and GHCi.
Previously, this was installed with an .exe, but now a package manager
for Windows called Chocolatey is used.

## GHC
GHC is the standard compiler (don’t use Hugs, it has not been in development for more
than a decade). It turns `.hs` files into runnable programs. If you want to use the
command line, you can simply do the following:

```
ghc MyFile.hs
```

This will give you MyFile.exe on Windows, or an executable MyFile.

For more help with ghc, try:

```
ghc --help
```

This will also let you know that ghc is correctly installed on your computer.

## GHCi

If you want to test the functions defined in the file, you can run ghci MyFile.hs
on it instead.

Create a file `MyFile.hs` with the following content:

```
1
foo :: Int
foo = 123
```

then load it into GHCi and ask it for the value of `foo`.

```
ghci MyFile.hs
*MyFile> foo
123
```

## Stack

Stack lets you manage dependencies (external libraries) of individual Haskell projects,
similar as what Maven does for Java and NPM for JavaScript.
A stack project has a configuration file where you can choose a database version (snapshot)
and list all the dependencies you want in your project.
When you run `stack build`,
stack will fetch the correct ghc-compiler and all your dependencies from the web.

You will not need stack in the beginning of INF222,
but we recommend that you install it now as we will explain its basics
in the crash course.

Install Stack [here](https://docs.haskellstack.org/en/stable/README/).

## Development Environment

IDE support for Haskell has traditionally been lacking,
but it is getting a lot better with the introduction of language servers.
We recommend VS Code with the Haskell plugin,
as it provides the most IDE-features,
but will list a few alternatives.

### Visual Studio Code

Vistual Studio Code is a text editor that implements the language client protocol.
You can download it [here](https://code.visualstudio.com/).

Make sure that the Haskell platform is installed before you continue.
You can install the plugin _Haskell_ from the VS Code marketplace,
which uses the Haskell Language Server to provide IDE-features.

You can either use the extensions-menu in the VSCode,
or go to [this link](https://marketplace.visualstudio.com/items?itemName=haskell.haskell)

### Extra: Improving the Feedback Loop

If your VSCode Haskell extension works,
then you're all set to start programming.
However,
compiling your program in GHC to find error messages can be tedious.
A faster alternative is to have a window running GHCi next to your code.
Then you can write code,
reload GHCi with `:r`, fix errors and repeat.
In fact, with this setup you don't need an IDE at all.

If you like this setup,
you should check out [GHCid](https://github.com/ndmitchell/ghcid).
It is a wrapper around GHCi,
and it reloads GHCi automatically on file save,
saving you a few seconds each time.

#### Compiler setting to help finding errors

To improve the feedback from GHC in GHCI,
you can add the following setting to help you find incomplete patterns in your functions.

```sh
> ghci
ghci > :set -Wincomplete-patterns
ghci > :show
options currently set: none.
base language is: Haskell2010
with the following modifiers:
  -XNoDatatypeContexts
  -XNondecreasingIndentation
GHCi-specific dynamic flag settings:
other dynamic, non-language, flag settings:
  -fexternal-dynamic-refs
  -fignore-optim-changes
  -fignore-hpc-changes
  -fimplicit-import-qualified
warning settings:
  -Wincomplete-patterns <-- has been added
ghci >
```

##### Example

```haskell
test :: [a] -> [a]
test (x:xs) = xs
```

This will give you the warning message:

```sh
test.hs:2:1: warning: [-Wincomplete-patterns]
    Pattern match(es) are non-exhaustive
    In an equation for ‘test’: Patterns not matched: []
  |
2 | test (x:xs) = xs
```

To resolve this do add the missing pattern or ignore it.
e.g. this will remove the warning.

```haskell
test :: [a] -> [a]
test [] = []
test (x:xs) = xs
```
