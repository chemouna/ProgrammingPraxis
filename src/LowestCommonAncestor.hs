
module LowestCommonAncestor where

-- https://programmingpraxis.com/2011/03/11/lowest-common-ancestor/

data BinTree a = Node a (BinTree a) (BinTree a) | Nil

lcaBst :: Ord a => a -> a -> BinTree a -> a
lcaBst m n ~(Node v l r) | n < v = lcaBst m n l
                      | m > v = lcaBst m n r
                      | otherwise = v


main :: IO ()
main = do let tip n = Node n Nil Nil
          let tree = Node 8 (Node 3 (tip 1) (Node 6 (tip 4) (tip 7)))
                            (Node 10 Nil (Node 14 (tip 13) Nil))
          print $ lcaBst 4  7 tree == 6
          print $ lcaBst 4 10 tree == 8
          print $ lcaBst 1  4 tree == 3
          print $ lcaBst 1  3 tree == 3
          print $ lcaBst 3  6 tree == 3


  
