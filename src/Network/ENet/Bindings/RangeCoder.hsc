{-# LANGUAGE CPP, ForeignFunctionInterface #-}
module Network.ENet.Bindings.RangeCoder where

import Foreign
import Foreign.Storable
import Foreign.C.Types

import Network.ENet.Bindings.System
--import Network.ENet.Bindings.Protocol
import Network.ENet.Bindings.List
import Network.ENet.Bindings.Callbacks
import Network.ENet.Bindings.Misc

foreign import ccall "enet.h enet_range_coder_create"      create
  :: IO (Ptr  RangeCoder)
foreign import ccall "enet.h enet_range_coder_destroy"     destroy
  :: Ptr RangeCoder -> IO ()
foreign import ccall "enet.h enet_range_coder_compresss"   compress
  :: Ptr RangeCoder -> Ptr Buffer -> CSize -> CSize -> Word8 -> CSize -> IO CSize
foreign import ccall "enet.h enet_range_coder_decompresss" decompresss
  :: Ptr RangeCoder -> Ptr Buffer -> CSize -> Word8 -> CSize -> IO CSize
