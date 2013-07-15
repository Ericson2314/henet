module Network.ENet.Peer where

import Foreign
import Foreign.C.Error
import Foreign.C.Types

import Network.Socket(SockAddr)

import Network.ENet.Internal
import qualified Network.ENet.Bindings as B

send :: Ptr B.Peer -> B.ChannelID -> Ptr B.Packet -> IO ()
send peer cID packet = do _ <- throwErrnoIf
                               (/=0)
                               "could not send packet"
                               $ B.peerSend peer cID packet
                          return ()

receive :: Ptr B.Peer -> B.ChannelID -> IO (Maybe (Ptr B.Packet))
receive peer cID = do ptr <- B.peerReceive peer cID
                      return $ if ptr == nullPtr
                               then Nothing
                               else Just ptr

ping :: Ptr B.Peer -> IO ()
ping = B.peerPing

pingInterval :: Ptr B.Peer -> Word32 -> IO ()
pingInterval = B.peerPingInterval

timeout :: Ptr B.Peer -> Word32 -> Word32 -> Word32 -> IO ()
timeout = B.peerTimeout

reset :: Ptr B.Peer -> IO ()
reset = B.peerReset

disconnect :: Ptr B.Peer -> Word32 -> IO ()
disconnect = B.peerDisconnect

disconnectNow :: Ptr B.Peer -> Word32 -> IO ()
disconnectNow = B.peerDisconnectNow

disconnectLater :: Ptr B.Peer -> Word32 -> IO ()
disconnectLater = B.peerDisconnectLater

throttleConfigure :: Ptr B.Peer -> Word32 -> Word32 -> Word32 -> IO ()
throttleConfigure = B.peerThrottleConfigure
