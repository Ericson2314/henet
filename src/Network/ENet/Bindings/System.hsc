{-# LANGUAGE CPP, ForeignFunctionInterface, EmptyDataDecls, GeneralizedNewtypeDeriving #-}
module Network.ENet.Bindings.System where
-- wraps both win32.h and unix.h with opaque types

import Foreign
import Foreign.Storable
import Foreign.C.Types

#include "enet/enet.h"

 -- cheating, CUInt is an accidental aggreement between systems
 -- hiding constructor to make this slightly less bad
newtype Socket = Socket CUInt
               deriving (Show, Eq, Storable)

-- Opaque/Abstract types, because system dependant

data Buffer
data SocketSet
