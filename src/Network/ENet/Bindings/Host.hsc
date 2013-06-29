{-# LANGUAGE CPP, ForeignFunctionInterface #-}
module Network.ENet.Bindings.Host where

import Foreign
import Foreign.Storable
import Foreign.C.Types

import Network.ENet.Bindings.System
--import Network.ENet.Bindings.Protocol
import Network.ENet.Bindings.List
import Network.ENet.Bindings.Callbacks
import Network.ENet.Bindings.Misc

foreign import ccall "enet.h enet_host_create"                    create
  :: Ptr Address -> CSize -> CSize -> Word32 -> Word32 -> IO (Ptr Host)
foreign import ccall "enet.h enet_host_destroy"                   destroy
  :: Ptr Host -> IO ()
foreign import ccall "enet.h enet_host_connect"                   connect
  :: Ptr Host -> Ptr Address -> CSize -> Word32 -> IO ()
foreign import ccall "enet.h enet_host_check_events"              checkEvents
  :: Ptr Host -> Ptr Event -> IO CUInt
foreign import ccall "enet.h enet_host_service"                   service
  :: Ptr Host -> Ptr Event -> Word32 -> IO CUInt
foreign import ccall "enet.h enet_host_flush"                     flush
  :: Ptr Host -> IO ()
foreign import ccall "enet.h enet_host_broadcast"                 broadcast
  :: Ptr Host -> Word8 -> Ptr Packet -> IO ()
foreign import ccall "enet.h enet_host_compress"                  compress
  :: Ptr Host -> Ptr Compressor -> IO ()
foreign import ccall "enet.h enet_host_compress_with_range_coder" compressWithRangeCoder
  :: Ptr Host -> IO CUInt
foreign import ccall "enet.h enet_host_channel_limit"             channelLimit
  :: Ptr Host -> CSize -> IO ()
foreign import ccall "enet.h enet_host_bandwidth_limit"           bandwidthLimit
  :: Ptr Host -> Word32 -> Word32 -> IO ()
