{-# LANGUAGE CPP, ForeignFunctionInterface, GeneralizedNewtypeDeriving #-}
module Network.ENet.Bindings.List where

import Foreign
import Foreign.Storable()
import Foreign.C.Types

#include "enet/enet.h"

data ENetListNode = ENetListNode { next     :: ENetListNode
                                 , previous :: ENetListNode
                                 }
                  deriving (Eq, Show)

instance Storable ENetListNode where
  sizeOf    _ = (#size ENetListNode)

  alignment _ = case size of
    1 -> 1
    2 -> 2
    3 -> 4
    n -> n
    where size = (#size ENetListNode)

  peek a = do n <- (#peek ENetListNode, next)     a
              p <- (#peek ENetListNode, previous) a
              return $ ENetListNode n p

  poke ptr (ENetListNode n p) = do (#poke ENetListNode, next)     ptr n
                                   (#poke ENetListNode, previous) ptr p

-- newtype in order to save redoing the storable
newtype ENetList = ENetList {sentinal :: ENetListNode}
                 deriving (Eq, Show, Storable)
