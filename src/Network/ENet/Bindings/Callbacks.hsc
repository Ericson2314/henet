{-# LANGUAGE CPP, ForeignFunctionInterface, ExistentialQuantification #-}
module Network.ENet.Bindings.Callbacks where

import Foreign
import Foreign.Storable()
import Foreign.C.Types

#include "enet/enet.h"

data Callbacks = forall a. Callbacks { malloc   :: Ptr (CSize -> Ptr a)
                                     , free     :: Ptr (Ptr a -> IO ())
                                     , noMemory :: Ptr (IO ())
                                     }

instance Storable Callbacks where
  sizeOf    _ = (#size ENetCallbacks)

  alignment _ = (#size ENetCallbacks) `min` 4 -- FIX THIS!

  peek ptr = do m <- (#peek ENetCallbacks, malloc)    ptr
                f <- (#peek ENetCallbacks, free)      ptr
                n <- (#peek ENetCallbacks, no_memory) ptr
                return $ Callbacks m f n

  poke ptr (Callbacks m f n) = do (#poke ENetCallbacks, malloc)    ptr m
                                  (#poke ENetCallbacks, free)      ptr f
                                  (#poke ENetCallbacks, no_memory) ptr n

--foreign import ccall "wrapper" factory ::
