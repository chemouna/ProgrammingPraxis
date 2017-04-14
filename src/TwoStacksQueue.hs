
module TwoStacksQueue where

type Queue a = ([a], [a])

enqueue :: a -> Queue a -> Queue a
enqueue a (l, r) = (a:l, r)

dequeue :: Queue a -> Maybe (a, Queue a)
dequeue ([], []) = Nothing
dequeue (l, []) = dequeue ([], reverse l)
dequeue (l, a:r) = Just (a, (l,r))

empty :: Queue a -> Bool
empty (l, r) = null l && null r
