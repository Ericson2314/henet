{-# OPTIONS_GHC -fno-warn-unused-imports #-}
#include <bindings.dsl.h>
#include "enet/include/enet/callbacks.h"
module Network.ENet.Bindings.Callbacks where
import Foreign.Ptr
#strict_import

{- typedef struct _ENetCallbacks {
            void * (* malloc)(size_t size);
            void (* free)(void * memory);
            void (* no_memory)(void);
        } ENetCallbacks; -}
#starttype _ENetCallbacks
#field malloc , FunPtr (CSize -> Ptr ())
#field free , FunPtr (Ptr () -> IO ())
#field no_memory , FunPtr (IO ())
#stoptype
#synonym_t ENetCallbacks , <_ENetCallbacks>
#ccall enet_malloc , CSize -> IO (Ptr ())
#ccall enet_free , Ptr () -> IO ()
