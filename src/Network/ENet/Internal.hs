module Network.ENet.Internal where

import Network.Socket.Internal

import Data.Endian
import Data.Endian.Unsafe( unsafeUnwrapBigEndian
                         , unsafeAssertBigEndian)

import Network.ENet.Bindings

toENetAddress :: SockAddr -> Address
toENetAddress (SockAddrInet (PortNum port) ip) =
  Address ip $ fromBigEndian $ unsafeAssertBigEndian port

toSockAddr :: Address -> SockAddr
toSockAddr (Address ip port) =
  SockAddrInet (PortNum $ unsafeUnwrapBigEndian $ toBigEndian $ port) ip
