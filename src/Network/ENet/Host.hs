module Network.ENet.Host where

import Foreign
import Foreign.C.Error
import Foreign.C.Types

import Network.Socket(SockAddr)

import Network.ENet.Internal
import qualified Network.ENet.Bindings as B


create :: Maybe SockAddr -> CSize -> CSize -> Word32 -> Word32 -> IO (Ptr B.Host)
create a c m i o  = withMaybeDo (fmap toENetAddress a) $ \a' -> B.hostCreate a' c m i o

destroy :: Ptr B.Host -> IO ()
destroy = B.hostDestroy

connect :: Ptr B.Host -> SockAddr -> CSize -> Word32 -> IO (Ptr B.Peer)
connect host address channelCount datum = alloca $ \addr -> do
  poke addr $ toENetAddress address
  throwErrnoIf
    (==nullPtr)
    "could not connect to peer"
    $ B.hostConnect host addr channelCount datum

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

broadcast :: Ptr B.Host -> B.ChannelID -> Ptr B.Packet -> IO ()
broadcast = B.hostBroadcast

compress :: Ptr B.Host -> Ptr B.Compressor -> IO ()
compress = B.hostCompress

compressWithRangeCoder :: Ptr B.Host -> IO CUInt
compressWithRangeCoder = B.hostCompressWithRangeCoder

channelLimit :: Ptr B.Host -> CSize -> IO ()
channelLimit = B.hostChannelLimit

hostBandwidthLimit :: Ptr B.Host -> Word32 -> Word32 -> IO ()
hostBandwidthLimit = B.hostBandwidthLimit
