# Haskell Crash Course

A repository for resources used in the Haskell crash course.

## Program

### Day 1
 - Coding environment: GHC, GHCi, VSCode
 - Common Types: `Int`, `Float`, `Bool`, `List`, `Char`, `String`, `Tuple`
 - Functions
 - Type notation
 - Prelude and the standard library
 - Documentation

### Day 2
 - Pattern matching in functions?
 - Mathematical operators (incl. `Int` vs `Float`, `Infix` vs `Prefix`)
 - Partial application (currying) and lambda functions
    - Show examples of partial application with mathematical operators
 - Control Structures
    - `if` (important: if-else as an expression)
    - `let`
    - `where`
    - `case`
    - guards
 - Type aliasing: `type`
 - Custom types: `data` (Sum types, `Maybe`, `Either`, BTL)

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
