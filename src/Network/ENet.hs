{-# LANGUAGE ScopedTypeVariables #-}
module Network.ENet where

import Foreign.C.Error

import Network.Socket(SockAddr(SockAddrInet, SockAddrInet6))

import qualified Network.ENet.Bindings as B

{-| Like 'withSocketsDo' from the network package. On windows it checks
the version of Winsock, initializes it, and then after execution of the
given variable deinitializes Winsock. Using  like this:

> main = withENetDo $ do {...}

It is likely 'withSocketsDo' will suffice in it's place, and vice versa,
but this has not been tested.
-}
withENetDo :: IO a -> IO a
withENetDo x = do throwErrnoIf
                    (/=0)
                    "ENet could not be initialized"
                    B.initialize
                  retVal <- x
                  B.deinitialize
                  return retVal
