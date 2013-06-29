{-# LANGUAGE CPP, ForeignFunctionInterface #-}
module Network.ENet.Bindings.Packet where

import Foreign
import Foreign.Storable
import Foreign.C.Types

import Network.ENet.Bindings.System
--import Network.ENet.Bindings.Protocol
import Network.ENet.Bindings.List
import Network.ENet.Bindings.Callbacks
import Network.ENet.Bindings.Misc

foreign import ccall "enet.h enet_packet_create"   send
  :: Ptr () -> CSize -> Word32 -> IO (Ptr Packet)
foreign import ccall "enet.h enet_packet_destroy"  destroy
  :: Ptr Packet -> IO ()
foreign import ccall "enet.h enet_packet_resize"   resize
  :: Ptr Packet -> CSize -> IO CInt
foreign import ccall "enet.h enet_crc32"           crc32
  :: Ptr Buffer -> CSize -> IO Word32
