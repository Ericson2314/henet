{-# LANGUAGE CPP, ForeignFunctionInterface #-}
module Network.ENet.Packet where

import Foreign as F
import Foreign.C.Error
import Foreign.C.Types

import Data.BitSet.Generic(BitSet(getBits))
import Data.ByteString.Unsafe

import Network.ENet
import qualified Network.ENet.Bindings as B

#include "enet/enet.h"

-- | Convert hENet packet to ENet packet.
{-|
Make sure 'NoAllocate' is not a member of the PacketFlag bitset, or its possible
the data of the packet will be GC'd before ENet can handle the packet. The
packet data will be copied by ENet, and thus the packet must be freed with
destroy.
-}
-- this ^ is why unsafe is OK
poke :: Packet -> IO (Ptr B.Packet)
poke (Packet f bs) = unsafeUseAsCStringLen bs $ \(ptr, len) ->
  B.packetCreate (castPtr ptr) (fromIntegral len) $ getBits f

destroy :: Ptr B.Packet -> IO ()
destroy = B.packetDestroy

-- | Convert ENet packet to hENet packet.
{-|
While the flag set is copied, the data will /not/ be copied. Instead the
ByteString will have destroy as it's finalizer. This means the original pointer
is no longer safe to use as it will become invalid whenever returned the hENet
packet is collected.
-}
peek :: Ptr B.Packet -> IO Packet
peek ptr = do f <- (#peek ENetPacket, flags     ) ptr
              p <- (#peek ENetPacket, data      ) ptr
              l <- (#peek ENetPacket, dataLength) ptr
              b <- unsafePackCStringFinalizer p l $ destroy ptr
              return $ Packet f b

resize :: Ptr B.Packet -> CSize -> IO ()
resize ptr size = do _ <- throwErrnoIf -- explicity throw away return after
                          (/=0)
                          "Packet could not be resized"
                          $ B.packetResize ptr size
                     return ()
