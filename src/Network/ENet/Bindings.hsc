{-# LANGUAGE CPP, ForeignFunctionInterface #-}
module Network.ENet.Bindings where

import Foreign
import Foreign.Storable
import Foreign.C.Types

import Network.ENet.Bindings.System
--import Network.ENet.Bindings.Protocol
import Network.ENet.Bindings.List
import Network.ENet.Bindings.Callbacks
import Network.ENet.Bindings.Misc

foreign import ccall "enet.h enet_initialize"                initialize
  :: IO CInt
foreign import ccall "enet.h enet_initialize_with_callbacks" initializeWithCallbacks
  :: Version -> Ptr Callbacks -> IO CInt
foreign import ccall "enet.h enet_deinitialize"              deinitialize
  :: IO ()
foreign import ccall "enet.h enet_linked_version"            linkedVersion
  :: IO Version

 -- private functions

foreign import ccall "enet.h enet_time_get" getTime :: IO Word32
foreign import ccall "enet.h enet_time_set" setTime :: Word32 -> IO ()
