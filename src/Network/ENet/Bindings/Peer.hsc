{-# LANGUAGE CPP, ForeignFunctionInterface #-}
module Network.ENet.Bindings.Peer where

import Foreign
import Foreign.Storable
import Foreign.C.Types

import Network.ENet.Bindings.System
--import Network.ENet.Bindings.Protocol
import Network.ENet.Bindings.List
import Network.ENet.Bindings.Callbacks
import Network.ENet.Bindings.Misc

foreign import ccall "enet.h enet_peer_send"               send
  :: Ptr Peer -> Word8 -> Ptr Packet -> IO CInt
foreign import ccall "enet.h enet_peer_receive"            receive
  :: Ptr Peer -> ChannelID -> IO (Ptr Packet)
foreign import ccall "enet.h enet_peer_ping"               ping
  :: Ptr Peer -> IO ()
foreign import ccall "enet.h enet_peer_ping_interval"      pingInterval
  :: Ptr Peer -> Word32 -> IO ()
foreign import ccall "enet.h enet_peer_timeout"            timeout
  :: Ptr Peer -> Word32 -> Word32 -> Word32 -> IO ()
foreign import ccall "enet.h enet_peer_reset"              reset
  :: Ptr Peer -> IO ()
foreign import ccall "enet.h enet_peer_disconnect"         disconnect
  :: Ptr Peer -> Word32 -> IO ()
foreign import ccall "enet.h enet_peer_disconnect_now"     disconnectNow
  :: Ptr Peer -> Word32 -> IO ()
foreign import ccall "enet.h enet_peer_disconnect_later"   disconnectLater
  :: Ptr Peer -> Word32 -> IO ()
foreign import ccall "enet.h enet_peer_throttle_configure" throttleConfigure
  :: Ptr Peer -> Word32 -> Word32 -> Word32 -> IO ()
