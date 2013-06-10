{-# OPTIONS_GHC -fno-warn-unused-imports #-}
#include <bindings.dsl.h>
#include "enet/include/enet/list.h"
module Network.ENet.Bindings.List where
import Foreign.Ptr
#strict_import

{- typedef struct _ENetListNode {
            struct _ENetListNode * next; struct _ENetListNode * previous;
        } ENetListNode; -}
#starttype _ENetListNode
#field next , Ptr <_ENetListNode>
#field previous , Ptr <_ENetListNode>
#stoptype
#synonym_t ENetListNode , <_ENetListNode>
{- typedef ENetListNode * ENetListIterator; -}
#synonym_t ENetListIterator , <_ENetListNode>
{- typedef struct _ENetList {
            ENetListNode sentinel;
        } ENetList; -}
#starttype _ENetList
#field sentinel , <_ENetListNode>
#stoptype
#synonym_t ENetList , <_ENetList>
#ccall enet_list_clear , Ptr <_ENetList> -> IO ()
#ccall enet_list_insert , <_ENetListNode> -> Ptr () -> IO (<_ENetListNode>)
#ccall enet_list_remove , <_ENetListNode> -> IO (Ptr ())
#ccall enet_list_move , <_ENetListNode> -> Ptr () -> Ptr () -> IO (<_ENetListNode>)
#ccall enet_list_size , Ptr <_ENetList> -> IO (CSize)
