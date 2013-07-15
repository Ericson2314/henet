module Network.ENet.Packet where

import Foreign
import Foreign.C.Error
import Foreign.C.Types

import Data.Word

import Data.BitSet.Generic(GBitSet, toBits, unsafeFromBits)

import qualified Data.ByteString        as SB
import qualified Data.ByteString.Unsafe as SB

import Data.Endian
import Data.Endian.Unsafe( unsafeUnwrapBigEndian
                         , unsafeAssertBigEndian)

import qualified Network.ENet.Bindings as B

type PacketFlagSet = GBitSet Word32 B.PacketFlag

-- String is defensively coppied, so unsafe is appropriate

create :: SB.ByteString -> PacketFlagSet -> IO (Ptr B.Packet)
create bytes flags = SB.unsafeUseAsCStringLen bytes $
              \(ptr,len) -> B.packetCreate (castPtr ptr) (fromIntegral len) $ toBits flags

destroy :: Ptr B.Packet -> IO ()
destroy = B.packetDestroy

resize :: Ptr B.Packet -> CSize -> IO ()
resize ptr size = do _ <- throwErrnoIf -- explicity throw away return after
                          (/=0)
                          "Packet could not be resized"
                          $ B.packetResize ptr size
                     return ()
