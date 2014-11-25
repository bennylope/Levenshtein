A simple module to return the Levenshtein distance between two strings.

The Levenshtein distance is simply the number of changes that need to be made
to make string A identical to string B. This is a beginner's coding exercise.
There's probably a much better, more Haskell-ish way of writing this, and
almost certainly an existing module to compute the same value.

Here's the module name. The only function I'm exposing as part of the public
API is the `distance` function.

> module Levenshtein (distance) where

Below is the main function. It's going to take two strings and return an
integer value. Irrespective of the number of arguments here in the type
definition it's the last that represents the type of the return value.

The arrows make a lot more sense when you realize that the function could be
curried. I love curry.

> distance :: String -> String -> Int
> distance a b
>     | a == b = 0
>     | length a == 0 = length b
>     | length b == 0 = length a
>     | otherwise =
>         let longer = getLonger a b
>             shorter = getShorter a b
>         in diffCount longer shorter 0 + length longer - length shorter

The pipes - they're guards. Basically like case statements for defining a
conditonal function body. The `=` indicates the function gets the body to the
right of this. It's not assigning the value on the right to the expression on
the left.

Note to self I'm constantly forgetting that when using guards the function name
isn't followed by the `=` operator. This is only applied after the guard
statements. Remember this!

If the two strings are identical the distance is 0, so we can return that and
be on our way. If either string is an empty string, the distance is the length
of the other string, since that's how many insertions would be required to make
the two strings identical.

If we have two non-identical, non-empty strings, then we need to properly
compare them. The intuitive way to do this, to me at least, is to iterate
through them and compare each character. We'll just loop - wait! There's no
loops. So the solution needs to be recursive. That'll be a separate function.

Will explain the shorter and longer functions shortly.

Here's our recursive distance finding function.

> diffCount :: String -> String -> Int -> Int
> diffCount _ "" c = c
> diffCount (x:xs) (y:ys) c
>     | x == y = diffCount xs ys c
>     | otherwise = diffCount xs ys (c + 1)

It takes two strings and an integer and returns an integer. The two strings are
the longer string, the shorter string, and the integer is the accumulated
distance. If the two strings are of equal length the order will be irrelevant.

If the shorter string is empty we stop and return the accumulated distance.
This is our base case.

Otherwise we compare the strings. The `(x:xs)` and `(y:ys)` business matches
our strings but binds the head and tail of each string, respectively, to named
variables. Head and tail are [0] and [1:] slices for the Pythonista. If the
head values are the same, there's no change required, so the distance stays the
same. Just call the function itself again with the tail of each string.

If they're not equal call itself with tail of each string and increment the
accumulated distance by one.

If you look back at the `distance` function you'll notice that it returns the
accumulated value of the `diffCount` function plus the difference in string
length. This ensures that we include all those insertions that aren't compared
- and can't be, of course.

The `getLonger` and `getShorer` functions ensure we know which string is longer
and which is shorter (its irrelevant if they're the same length). This is
important because we only want to compare the strings up to the length of the
shorter string. It makes no sense to do otherwise, and we'd run into an error
trying to get the head value of an empty string.

> getLonger :: String -> String -> String
> getLonger a "" = a
> getLonger "" a = a
> getLonger a b
>     | length a > length b = a
>     | otherwise = b

If one of the strings is an empty string - for some reason - always return the
other.

> getShorter :: String -> String -> String
> getShorter a b
>     | length a > length b = b
>     | otherwise = a

You'll notice `getShorter` uses the same conditionals as `getLonger` to ensure
that we always get the opposite string, even if the two are the same lenth.

In hindsight some of those patterns for the original function are unnecessary
since they're taken care of by the `diffCount` function. However it returns
quicker this way, and more importantly, I wrote the `distance` function first
and didn't care to change it.
