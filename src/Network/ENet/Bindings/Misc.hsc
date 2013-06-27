{-# LANGUAGE CPP, ForeignFunctionInterface, EmptyDataDecls, GeneralizedNewtypeDeriving #-}
module Network.ENet.Bindings.Misc where

import Foreign
import Foreign.Storable
import Foreign.C.Types

import Network.ENet.Bindings.System
--import Network.ENet.Bindings.Protocol
import Network.ENet.Bindings.List
import Network.ENet.Bindings.Callbacks

#include "enet/enet.h"

------

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

data SocketWait = Send | Recieve | Interrupt
                deriving (Show, Eq, Enum) -- safe because used in set

------

data SocketOption = NonBlock
                  | Broadcast
                  | ReceiveBuffer
                  | SendBuffer
                  | ReuseAddress
                  | ReceiveTimeIs0
                  | SendTimeIs0
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

------

hostAny :: IP -- | specifies the default server host
hostAny  = IPv4 0

hostBroadcast :: IP -- | specifies a subnet-wide broadcast
hostBroadcast  = IPv4 0xFFFFFFFF

portAny :: Port -- | specifies that a port should be automatically chosen
portAny  = Port 0

------

newtype IP   = IPv4 Word32 deriving (Show, Eq, Storable)
newtype Port = Port Word16 deriving (Show, Eq, Storable)

data Address = Address IP Port

instance Storable Address where
  sizeOf    _ = (#size ENetAddress)
  alignment _ = (#size void*) -- FIX THIS!
  peek ptr = do h <- (#peek ENetAddress, host) ptr
                p <- (#peek ENetAddress, port) ptr
                return $ Address h p
  poke ptr (Address h p) = do (#poke ENetAddress, host) ptr h
                              (#poke ENetAddress, port) ptr p

------

-- Opaque/Abstract types, cause I am lazy

data PacketFlag
data Packet
data Acknowledgement
data OutgoingCommand
data IncomingCommand
data PeerState
data Channel
data Peer
data Compresor
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

data Event = Event
             EventType
             (Ptr Peer)
             Word8
             Word32 -- | event data
             (Ptr Packet                   )

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
