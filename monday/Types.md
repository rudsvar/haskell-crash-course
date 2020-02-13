# Types

## Why do we need types at all?

Types is what seperates i.e. a string from a number

Typing helps the programmer to understand the code, like what a function is supposed to return or needs as arguments

Typing helps the compiler and other tools to reason about the code, and let you know if something is wrong

## Types in Haskell

Alle expressions in Haskell has types. (Values, functions, etc.)

Haskell has strong, static typing: The compiler don't let you run a program with type error, and the types cannot change.
Haskell is also purely functional, meaning it consists of _pure_ functions. Pure functions always give the same output for the same input - no sideeffects!

These two concepts go hand in hand: When the entire codebase is all functions, the compiler only needs to check the input and output of the functions to check if a program is well typed. The algorithm for type checking the code is actually quite simple, and something one learns in INF122. (Not needed for 222).

Understanding how types work is key to understand Haskell and its advantages.

If you want to check the type of something, use `:t` in ghci.

`::` reads "has type"

ex `5 :: Int`, "5 has type Int"

Exercises: Check the type of

- True
- False
- "En streng"
- id
- not
- [True, True, False]
- [True, "False"] <- Hva sier feilmeldingen?

Concrete types (Int, Bool, ...) start with capital letters

Typevariables start with small letters, and often one letter only: a, b, c, t0, t1, ...
Typevariables can be any type, as long as all occurrences of that typevariable has the same type.

Ex: `id :: a -> a`. If we choose the first a to be Int, then the second a becomes Int too.

Typevariables is good, because it lets you use a function for many different cases.
When a function uses typevariables, we say it's _polymorphic_.

Typeclasses let you use typevariables with requirements - class constraints. Examples of usage:

- "You can use any type here, as long as the type can be converted to a string". (this is the typeclass `Show`)
- "You can use any type here, as long as the type supports numerical operations like + and -". (this is the typeclass `Num`)

Exercise: Check the type of `10`.

Everything before `=>` is called a class constraint. A type can have many class constraints, these will all be comma seperated before the `=>`.

## Finally

Even though GHC is extremely good at doing type inference (finding the types of your functions), try to always be explicit about your types. This is both helpful for you as a programmer and for the compiler to report type errors at the right place.

And when looking at names and error messages and such, **always** know whether you are in the type world or expression world.

For more details, read the [Types and Typeclasses](http://learnyouahaskell.com/types-and-typeclasses) section of the Learn You A Haskell book.
