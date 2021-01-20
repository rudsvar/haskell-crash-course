# INF222 Haskell Crash Course

## Installation

For Haskell installation instructions, click [here](installation.md) (takes 20-30 min).

## Program

### Day 1
 - Coding environment: GHC, GHCi, VSCode
 - Commond Types: `Int`, `Float`, `Bool`, `List`, `Char`, `String`, `Tuple`
 - Functions
 - Type notation
 - Prelude and the standard library
 - Documentation

### Day 2
 - Type aliasing: `type`
 - Custom types: `data` (Sum types, `Maybe`, `Either`, BTL)
 - Partial application (currying) and lambda functions
 - Mathematical operators (incl. `Int` vs `Float`, `Infix` vs `Prefix`)
 - Control Structures
    - `case`
    - `where`
    - guards
    - pattern matching

### Day 3
  - Higher order functions (`map`, `filter`, `any`, `all`) instead recursion
  - Typeclasses: `Show`, `Eq`, `Num` (and also how to create a typeclass `Add`)
  - `IO`
    - `main`-function
    - `do`-notation
    - `getLine`
    - `putStrLn`
    - `readFile`
    - `writeFile`
  - IO and `read`: Preventing ambigous types
  - The basics of the Stack package manager: Adding `random` as a dependency in your Haskell project.

## Recommended online resources
  - Searching for documentation: [Hoogle](https://hoogle.haskell.org/)
  - Prelude documentation: [Prelude](https://hackage.haskell.org/package/base-4.14.0.0/docs/Prelude.html)
  - Book for beginners: [Learn You a Haskell for Great Good](http://learnyouahaskell.com/chapters)
  - A more advanced book: [Real World Haskell](http://book.realworldhaskell.org/)
  - Useful tips: [What I Wish I Knew When Learning Haskell](http://dev.stephendiehl.com/hask/)