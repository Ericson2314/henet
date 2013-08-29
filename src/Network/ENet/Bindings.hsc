{-# LANGUAGE CPP, ForeignFunctionInterface, EmptyDataDecls, GeneralizedNewtypeDeriving #-}
module Network.ENet.Bindings where

import Foreign
import Foreign.Storable
import Foreign.C.Types
import Foreign.C.String

import Network.Socket( SockAddr(SockAddrInet)
                     , HostAddress)
import Network.Socket.Internal(PortNumber(PortNum))

import Network.ENet.Bindings.System
--import Network.ENet.Bindings.Protocol
import Network.ENet.Bindings.List
import Network.ENet.Bindings.Callbacks

#include "enet/enet.h"

------------------------------------------------------------
-- Types
------------------------------------------------------------

newtype Version = Version Word32

------

data SocketType = Stream | Datagram
                deriving (Show, Eq)

instance Enum SocketType where
  fromEnum Stream   = 1
  fromEnum Datagram = 2
  toEnum 1 = Stream
  toEnum 2 = Datagram

instance Storable SocketType where
  sizeOf    _ = (#size ENetSocketType)
  alignment _ = (#size void*) -- FIX THIS!
  peek ptr = (toEnum . fromIntegral) `fmap` (peekByteOff ptr 0 :: IO CUInt)
  poke ptr e = pokeByteOff ptr 0 $ (fromIntegral $ fromEnum e :: CUInt)

------

data SocketOption = NonBlock
                  | Broadcast
                  | ReceiveBuffer
                  | SendBuffer
                  | ReuseAddress
                  | ReceiveTimeIs0
                  | SendTimeIs0
                  | Error
                  deriving (Show, Eq)

instance Enum SocketOption where
  fromEnum NonBlock       = 1
  fromEnum Broadcast      = 2
  fromEnum ReceiveBuffer  = 3
  fromEnum SendBuffer     = 4
  fromEnum ReuseAddress   = 5
  fromEnum ReceiveTimeIs0 = 6
  fromEnum SendTimeIs0    = 7
  toEnum 1 = NonBlock
  toEnum 2 = Broadcast
  toEnum 3 = ReceiveBuffer
  toEnum 4 = SendBuffer
  toEnum 5 = ReuseAddress
  toEnum 6 = ReceiveTimeIs0
  toEnum 7 = SendTimeIs0

instance Storable SocketOption where
  sizeOf    _ = (#size ENetSocketOption)
  alignment _ = (#size void*) -- FIX THIS!
  peek ptr = (toEnum . fromIntegral) `fmap` (peekByteOff ptr 0 :: IO CUInt)
  poke ptr e = pokeByteOff ptr 0 $ (fromIntegral $ fromEnum e :: CUInt)

------

data SocketShutdown = Read | Write | ReadWrite
                    deriving (Show, Eq, Enum) -- safe because starts on 0

instance Storable SocketShutdown where
  sizeOf    _ = (#size ENetSocketShutdown)
  alignment _ = (#size void*) -- FIX THIS!
  peek ptr = (toEnum . fromIntegral) `fmap` (peekByteOff ptr 0 :: IO CUInt)
  poke ptr e = pokeByteOff ptr 0 $ (fromIntegral $ fromEnum e :: CUInt)

data Address = Address HostAddress Word16

instance Storable Address where
  sizeOf    _ = (#size ENetAddress)
  alignment _ = (#size void*) -- FIX THIS!
  peek ptr = do h <- (#peek ENetAddress, host) ptr
                p <- (#peek ENetAddress, port) ptr
                return $ Address h p
  poke ptr (Address h p) = do (#poke ENetAddress, host) ptr h
                              (#poke ENetAddress, port) ptr p

------

data PacketFlag = Reliable
                | Unsequenced
                | NoAllocate
                | UnreliableFragment
                | PF_Unused_1
                | PF_Unused_2
                | PF_Unused_3
                | PF_Unused_4
                | IsSent
                deriving (Show, Eq, Enum) -- safe because used in bitset

------

-- Opaque/Abstract types, cause I am lazy

data Packet
data Acknowledgement
data OutgoingCommand
data IncomingCommand
data PeerState
data Channel
data Peer
data Compressor
data Host

------

data EventType = None | Connect | Disconnect | Receive
               deriving (Show, Eq, Enum) -- safe because starts on 0

instance Storable EventType where
  sizeOf    _ = (#size ENetEventType)
  alignment _ = (#size void*) -- FIX THIS!
  peek ptr = (toEnum . fromIntegral) `fmap` (peekByteOff ptr 0 :: IO CUInt)
  poke ptr e = pokeByteOff ptr 0 $ (fromIntegral $ fromEnum e :: CUInt)

------

newtype ChannelID = ChannelID Word8
                  deriving (Show, Eq, Storable)

data Event = Event
             EventType
             (Ptr Peer)
             ChannelID
             Word32 -- | event data
             (Ptr Packet)

instance Storable Event where
  sizeOf    _ = (#size ENetEvent)
  alignment _ = (#size void*) -- FIX THIS!
  peek ptr = do t  <- (#peek ENetEvent, type)      ptr
                pe <- (#peek ENetEvent, peer)      ptr
                c  <- (#peek ENetEvent, channelID) ptr
                d  <- (#peek ENetEvent, data)      ptr
                pa <- (#peek ENetEvent, packet)    ptr
                return $ Event t pe c d pa
  poke ptr (Event t pe c d pa) =
    do (#poke ENetEvent, type)      ptr t
       (#poke ENetEvent, peer)      ptr pe
       (#poke ENetEvent, channelID) ptr c
       (#poke ENetEvent, data)      ptr d
       (#poke ENetEvent, packet)    ptr pa

------

data RangeCoder

------------------------------------------------------------
-- Functions
------------------------------------------------------------


 -- Global functions

foreign import ccall unsafe "enet.h enet_initialize"                initialize
  :: IO CInt
foreign import ccall unsafe "enet.h enet_initialize_with_callbacks" initializeWithCallbacks
  :: Version -> Ptr Callbacks -> IO CInt
foreign import ccall unsafe "enet.h enet_deinitialize"              deinitialize
  :: IO ()
foreign import ccall unsafe "enet.h enet_linked_version"            linkedVersion
  :: IO Version

foreign import ccall unsafe "enet.h enet_time_get"                  timeGet
  :: IO Word32
foreign import ccall unsafe "enet.h enet_time_set"                  timeSet
  :: Word32 -> IO ()


 -- Socket Functions

foreign import ccall unsafe "enet.h enet_socket_create"      socketCreate
  :: CUInt -> IO Socket
foreign import ccall unsafe "enet.h enet_socket_bind"        socketBind
  :: Socket -> Ptr Address -> IO CInt
foreign import ccall unsafe "enet.h enet_socket_get_address" socketGetAddress
  :: Socket -> Ptr Address -> IO CInt
foreign import ccall unsafe "enet.h enet_socket_listen"      socketListen
  :: Socket -> CInt -> IO CInt
foreign import ccall unsafe "enet.h enet_socket_accept"      socketAccept
  :: Socket -> Ptr Address -> IO Socket
foreign import ccall unsafe "enet.h enet_socket_connect"     socketConnect
  :: Socket -> Ptr Address -> IO CInt
foreign import ccall unsafe "enet.h enet_socket_send"        socketSend
  :: Socket -> Ptr Address -> Ptr Buffer -> CSize -> IO CInt
foreign import ccall unsafe "enet.h enet_socket_receive"     socketReceive
  :: Socket -> Ptr Address -> Ptr Buffer -> CSize -> IO CInt
foreign import ccall unsafe "enet.h enet_socket_wait"        socketWait
  :: Socket -> Ptr Word32 -> Ptr Word32 -> IO CInt
foreign import ccall unsafe "enet.h enet_socket_set_option"  socketSetOption
  :: Socket -> CUInt -> CInt -> IO CInt
foreign import ccall unsafe "enet.h enet_socket_get_option"  socketGetOption
  :: Socket -> CUInt -> Ptr CInt -> IO CInt
foreign import ccall unsafe "enet.h enet_socket_shutdown"    socketShutdown
  :: Socket -> CUInt -> IO CInt
foreign import ccall unsafe "enet.h enet_socket_destroy"     socketDestroy
  :: Socket -> IO ()
foreign import ccall unsafe "enet.h enet_socketset_select"   socketSelectSet
  :: Socket -> Ptr SocketSet -> Ptr SocketSet -> Word32 -> IO CInt


 -- Address Functions

foreign import ccall unsafe "enet.h enet_address_set_host"    addressSetHost
  :: Ptr Address -> IO CString
foreign import ccall unsafe "enet.h enet_address_get_host_ip" addressGetHostIP
  :: Ptr Address -> CString -> IO CSize
foreign import ccall unsafe "enet.h enet_address_get_host"    addressGetHost
  :: Ptr Address -> CString -> IO CSize


 -- Packet Functions

foreign import ccall unsafe "enet.h enet_packet_create"   packetCreate
  :: Ptr () -> CSize -> Word32 -> IO (Ptr Packet)
foreign import ccall unsafe "enet.h enet_packet_destroy"  packetDestroy
  :: Ptr Packet -> IO ()
foreign import ccall unsafe "enet.h enet_packet_resize"   packetResize
  :: Ptr Packet -> CSize -> IO CInt
foreign import ccall unsafe "enet.h enet_crc32"           crc32
  :: Ptr Buffer -> CSize -> IO Word32


 -- Host Functions

foreign import ccall unsafe "enet.h enet_host_create"                    hostCreate
  :: Ptr Address -> CSize -> CSize -> Word32 -> Word32 -> IO (Ptr Host)
foreign import ccall unsafe "enet.h enet_host_destroy"                   hostDestroy
  :: Ptr Host -> IO ()
foreign import ccall unsafe "enet.h enet_host_connect"                   hostConnect
  :: Ptr Host -> Ptr Address -> CSize -> Word32 -> IO (Ptr Peer)
foreign import ccall unsafe "enet.h enet_host_check_events"              hostCheckEvents
  :: Ptr Host -> Ptr Event -> IO CUInt
foreign import ccall unsafe "enet.h enet_host_service"                   hostService
  :: Ptr Host -> Ptr Event -> Word32 -> IO CUInt
foreign import ccall unsafe "enet.h enet_host_flush"                     hostFlush
  :: Ptr Host -> IO ()
foreign import ccall unsafe "enet.h enet_host_broadcast"                 hostBroadcast
  :: Ptr Host -> ChannelID -> Ptr Packet -> IO ()
foreign import ccall unsafe "enet.h enet_host_compress"                  hostCompress
  :: Ptr Host -> Ptr Compressor -> IO ()
foreign import ccall unsafe "enet.h enet_host_compress_with_range_coder" hostCompressWithRangeCoder
  :: Ptr Host -> IO CUInt
foreign import ccall unsafe "enet.h enet_host_channel_limit"             hostChannelLimit
  :: Ptr Host -> CSize -> IO ()
foreign import ccall unsafe "enet.h enet_host_bandwidth_limit"           hostBandwidthLimit
  :: Ptr Host -> Word32 -> Word32 -> IO ()


 -- Peer Functions

foreign import ccall unsafe "enet.h enet_peer_send"               peerSend
  :: Ptr Peer -> ChannelID -> Ptr Packet -> IO CInt
foreign import ccall unsafe "enet.h enet_peer_receive"            peerReceive
  :: Ptr Peer -> ChannelID -> IO (Ptr Packet)
foreign import ccall unsafe "enet.h enet_peer_ping"               peerPing
  :: Ptr Peer -> IO ()
foreign import ccall unsafe "enet.h enet_peer_ping_interval"      peerPingInterval
  :: Ptr Peer -> Word32 -> IO ()
foreign import ccall unsafe "enet.h enet_peer_timeout"            peerTimeout
  :: Ptr Peer -> Word32 -> Word32 -> Word32 -> IO ()
foreign import ccall unsafe "enet.h enet_peer_reset"              peerReset
  :: Ptr Peer -> IO ()
foreign import ccall unsafe "enet.h enet_peer_disconnect"         peerDisconnect
  :: Ptr Peer -> Word32 -> IO ()
foreign import ccall unsafe "enet.h enet_peer_disconnect_now"     peerDisconnectNow
  :: Ptr Peer -> Word32 -> IO ()
foreign import ccall unsafe "enet.h enet_peer_disconnect_later"   peerDisconnectLater
  :: Ptr Peer -> Word32 -> IO ()
foreign import ccall unsafe "enet.h enet_peer_throttle_configure" peerThrottleConfigure
  :: Ptr Peer -> Word32 -> Word32 -> Word32 -> IO ()


 -- Range Coder Functions

foreign import ccall unsafe "enet.h enet_range_coder_create"     rangeCoderCreate
  :: IO (Ptr  RangeCoder)
foreign import ccall unsafe "enet.h enet_range_coder_destroy"    rangeCoderDestroy
  :: Ptr RangeCoder -> IO ()
foreign import ccall unsafe "enet.h enet_range_coder_compress"   rangeCoderCompress
  :: Ptr RangeCoder -> Ptr Buffer -> CSize -> CSize -> Word8 -> CSize -> IO CSize
foreign import ccall unsafe "enet.h enet_range_coder_decompress" rangeCoderDecompress
  :: Ptr RangeCoder -> Ptr Buffer -> CSize -> Word8 -> CSize -> IO CSize
