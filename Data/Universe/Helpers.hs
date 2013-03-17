module Data.Universe.Helpers (
	-- | This module is for functions that are useful for writing instances,
	-- but not necessarily for using them (and hence are not exported by the
	-- main module to avoid cluttering up the namespace).
	module Data.Universe.Helpers
	) where

import Data.List

-- | For many types, the 'universe' should be @[minBound .. maxBound]@;
-- 'universeDef' makes it easy to make such types an instance of 'Universe' via
-- the snippet
--
-- > instance Universe Foo where universe = universeDef
universeDef :: (Bounded a, Enum a) => [a]
universeDef = [minBound .. maxBound]

-- | Fair n-way interleaving: given a finite number of (possibly infinite)
-- lists, produce a single list such that whenever @v@ has finite index in one
-- of the input lists, @v@ also has finite index in the output list.
interleave :: [[a]] -> [a]
interleave = concat . transpose

-- | Fair 2-way interleaving.
(+++) :: [a] -> [a] -> [a]
xs +++ ys = interleave [xs,ys]

-- | Fair 2-way Cartesian product: given two (possibly infinite) lists, produce
-- a single list such that whenever @v@ and @w@ have finite indices in the
-- input list, @(v,w)@ has finite index in the output list.
(+*+) :: [a] -> [b] -> [(a,b)]
(x:xs) +*+ ys = map ((,) x) ys +++ (xs +*+ ys)
[] +*+ ys = []