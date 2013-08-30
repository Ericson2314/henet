{-# LANGUAGE ScopedTypeVariables #-}
module Network.ENet where

import Control.Concurrent (runInBoundThread)

import Data.ByteString (ByteString)
import Data.Word (Word32)
import Data.BitSet.Generic (BitSet(getBits))

import Foreign.C.Error

import Network.Socket(SockAddr(SockAddrInet, SockAddrInet6))

import qualified Network.ENet.Bindings as B

{-| Like 'withSocketsDo' from the network package. On windows it checks the
version of Winsock, initializes it, and then after execution of the given
variable deinitializes Winsock.

ENet has no concurrency support (though you can do unrelated things in other
threads). That means that unless you really know what you are doing, you
shouldn't call 'withENetDo' more than once.

Lastly, 'withENetDo' makes sure ENet runs in a bound thread. ENet functions are
imported unsafely which means that they are run in the same Haskell thread and
OS thread as their caller. Use of a bound thread further guarantees that when
control returns to the Haskell caller, it is run in the same OS thread. ENet
will almost always be called from a loop running almost the entire duration of
the program.  Therefore, the combination of bound threads and unsafe imports
should reduce the number of costly OS thread context switches.

Use 'withENetDo' like this:

> main = withENetDo $ do {...}

It is likely 'withSocketsDo . runInBoundThread' will suffice in this function's
place, and vice versa, but this has not been tested.
-}
withENetDo :: IO a -> IO a
withENetDo x = runInBoundThread $ do
  throwErrnoIf
    (/=0)
    "ENet could not be initialized"
    B.initialize
  retVal <- x
  B.deinitialize
  return retVal

type PacketFlagSet = BitSet Word32 B.PacketFlag

-- | A more high level notion of a packet than used by the basic Bindings
data Packet = Packet PacketFlagSet ByteString
