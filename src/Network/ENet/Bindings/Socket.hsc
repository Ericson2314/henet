{-# LANGUAGE CPP, ForeignFunctionInterface #-}
module Network.ENet.Bindings.Socket where

import Foreign
import Foreign.Storable
import Foreign.C.Types

import Data.BitSet.Generic

import Network.ENet.Bindings.System
--import Network.ENet.Bindings.Protocol
import Network.ENet.Bindings.List
import Network.ENet.Bindings.Callbacks
import Network.ENet.Bindings.Misc

foreign import ccall "enet.h enet_socket_create"      create_C
  :: CUInt -> IO Socket
foreign import ccall "enet.h enet_socket_bind"        bind
  :: Socket -> Ptr Address -> IO CInt
foreign import ccall "enet.h enet_socket_get_address" getAddress
  :: Socket -> Ptr Address -> IO CInt
foreign import ccall "enet.h enet_socket_list"        listen
  :: Socket -> CInt -> IO CInt
foreign import ccall "enet.h enet_socket_accept"      accept
  :: Socket -> Ptr Address -> IO Socket
foreign import ccall "enet.h enet_socket_connect"     connect
  :: Socket -> Ptr Address -> IO CInt
foreign import ccall "enet.h enet_socket_send"        send
  :: Socket -> Ptr Address -> Ptr Buffer -> CSize -> IO CInt
foreign import ccall "enet.h enet_socket_receive"     receive
  :: Socket -> Ptr Address -> Ptr Buffer -> CSize -> IO CInt
foreign import ccall "enet.h enet_socket_wait"        wait
  :: Socket -> Ptr Word32 -> Ptr Word32 -> IO CInt
foreign import ccall "enet.h enet_socket_set_option"  setOption_C
  :: Socket -> CUInt -> CInt -> IO CInt
foreign import ccall "enet.h enet_socket_shutdown"    shutdown_C
  :: Socket -> CUInt -> IO CInt
foreign import ccall "enet.h enet_socket_destroy"     destroy
  :: Socket -> IO ()
foreign import ccall "enet.h enet_socketset_select"   selectSet
  :: Socket -> Ptr SocketSet -> Ptr SocketSet -> Word32 -> IO CInt

-- more type safe wrappers

create :: SocketType -> IO Socket
create enum = create_C $ fromIntegral $ fromEnum enum

setOption :: Socket -> SocketOptionSet -> CInt -> IO CInt
setOption socket bitset = setOption_C socket $ toBits bitset -- point-free

shutdown :: Socket -> SocketShutdown -> IO CInt
shutdown socket enum = shutdown_C socket $ fromIntegral $ fromEnum enum
