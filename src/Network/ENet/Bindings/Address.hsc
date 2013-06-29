{-# LANGUAGE CPP, ForeignFunctionInterface #-}
module Network.ENet.Bindings.Address where

import Foreign
import Foreign.Storable
import Foreign.C.Types
import Foreign.C.String

import Network.ENet.Bindings.System
--import Network.ENet.Bindings.Protocol
import Network.ENet.Bindings.List
import Network.ENet.Bindings.Callbacks
import Network.ENet.Bindings.Misc

foreign import ccall "enet.h enet_address_set_host"    setHost
  :: Ptr Address -> IO CString
foreign import ccall "enet.h enet_address_get_host_ip" getHostIP
  :: Ptr Address -> CString -> IO CSize
foreign import ccall "enet.h enet_address_get_host"    getHost
  :: Ptr Address -> CString -> IO CSize
