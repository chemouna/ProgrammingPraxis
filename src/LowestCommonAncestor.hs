
module LowestCommonAncestor where

-- https://programmingpraxis.com/2011/03/11/lowest-common-ancestor/

data BinTree a = Node a (BinTree a) (BinTree a) | Nil

lca :: Ord a => a -> a -> BinTree a -> a
lca m n ~(Node v l r) | n < v = lca m n l
                      | m > v = lca m n r
                      | otherwise = v

main :: IO ()
main = do let tip n = Node n Nil Nil
          let tree = Node 8 (Node 3 (tip 1) (Node 6 (tip 4) (tip 7)))
                            (Node 10 Nil (Node 14 (tip 13) Nil))
          print $ lca 4  7 tree == 6
          print $ lca 4 10 tree == 8
          print $ lca 1  4 tree == 3
          print $ lca 1  3 tree == 3
          print $ lca 3  6 tree == 3


