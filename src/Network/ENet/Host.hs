module Network.ENet.Host where

import Foreign
import Foreign.C.Error
import Foreign.C.Types

import Network.Socket(SockAddr)

import Network.ENet.Internal
import qualified Network.ENet.Bindings as B


create :: SockAddr -> CSize -> CSize -> Word32 -> Word32 -> IO (Ptr B.Host)
create address peerCount maxChannels inBandwidth outBandwidth = alloca $ \addr -> do 
  poke addr $ toENetAddress address
  B.hostCreate addr peerCount maxChannels inBandwidth outBandwidth

destroy :: Ptr B.Host -> IO ()
destroy = B.hostDestroy

connect :: Ptr B.Host -> SockAddr -> CSize -> Word32 -> IO ()
connect host address channelCount datum = alloca $ \addr -> do
  poke addr $ toENetAddress address
  B.hostConnect host addr channelCount datum

checkEvents :: Ptr B.Host -> IO (Maybe B.Event)
checkEvents host = alloca $ \ptr -> do
  status <- B.hostCheckEvents host ptr
  case compare status 0 of
    GT -> fmap Just $ peek ptr
    EQ -> return $ Nothing
    LT -> throwErrno "error checking events"

service :: Ptr B.Host -> Word32 -> IO (Maybe B.Event)
service host timeout = alloca $ \ptr -> do
  status <- B.hostService host ptr timeout
  case compare status 0 of
    GT -> fmap Just $ peek ptr
    EQ -> return $ Nothing
    LT -> throwErrno "error servicing events"

flush :: Ptr B.Host -> IO ()
flush = B.hostFlush

broadcast :: Ptr B.Host -> Word8 -> Ptr B.Packet -> IO ()
broadcast = B.hostBroadcast

compress :: Ptr B.Host -> Ptr B.Compressor -> IO ()
compress = B.hostCompress

compressWithRangeCoder :: Ptr B.Host -> IO CUInt
compressWithRangeCoder = B.hostCompressWithRangeCoder

channelLimit :: Ptr B.Host -> CSize -> IO ()
channelLimit = B.hostChannelLimit

hostBandwidthLimit :: Ptr B.Host -> Word32 -> Word32 -> IO ()
hostBandwidthLimit = B.hostBandwidthLimit
