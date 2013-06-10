{-# OPTIONS_GHC -fno-warn-unused-imports #-}
#include <bindings.dsl.h>
#include "enet/enet.h"
module Network.ENet.Bindings where
import Foreign.Ptr
#strict_import

import Network.ENet.Bindings/win32
import Network.ENet.Bindings/unix
import Network.ENet.Bindings/types
import Network.ENet.Bindings/protocol
import Network.ENet.Bindings/list
import Network.ENet.Bindings/callbacks
{- typedef enet_uint32 ENetVersion; -}
#synonym_t ENetVersion , Word32
{- struct _ENetHost; -}
#opaque_t _ENetHost
{- struct _ENetEvent; -}
#opaque_t _ENetEvent
{- struct _ENetPacket; -}
#opaque_t _ENetPacket
{- typedef enum _ENetSocketType {
            ENET_SOCKET_TYPE_STREAM = 1, ENET_SOCKET_TYPE_DATAGRAM = 2
        } ENetSocketType; -}
#integral_t _ENetSocketType
#num ENET_SOCKET_TYPE_STREAM
#num ENET_SOCKET_TYPE_DATAGRAM
#synonym_t ENetSocketType , <_ENetSocketType>
{- typedef enum _ENetSocketWait {
            ENET_SOCKET_WAIT_NONE = 0,
            ENET_SOCKET_WAIT_SEND = 1 << 0,
            ENET_SOCKET_WAIT_RECEIVE = 1 << 1,
            ENET_SOCKET_WAIT_INTERRUPT = 1 << 2
        } ENetSocketWait; -}
#integral_t _ENetSocketWait
#num ENET_SOCKET_WAIT_NONE
#num ENET_SOCKET_WAIT_SEND
#num ENET_SOCKET_WAIT_RECEIVE
#num ENET_SOCKET_WAIT_INTERRUPT
#synonym_t ENetSocketWait , <_ENetSocketWait>
{- typedef enum _ENetSocketOption {
            ENET_SOCKOPT_NONBLOCK = 1,
            ENET_SOCKOPT_BROADCAST = 2,
            ENET_SOCKOPT_RCVBUF = 3,
            ENET_SOCKOPT_SNDBUF = 4,
            ENET_SOCKOPT_REUSEADDR = 5,
            ENET_SOCKOPT_RCVTIMEO = 6,
            ENET_SOCKOPT_SNDTIMEO = 7
        } ENetSocketOption; -}
#integral_t _ENetSocketOption
#num ENET_SOCKOPT_NONBLOCK
#num ENET_SOCKOPT_BROADCAST
#num ENET_SOCKOPT_RCVBUF
#num ENET_SOCKOPT_SNDBUF
#num ENET_SOCKOPT_REUSEADDR
#num ENET_SOCKOPT_RCVTIMEO
#num ENET_SOCKOPT_SNDTIMEO
#synonym_t ENetSocketOption , <_ENetSocketOption>
{- typedef enum _ENetSocketShutdown {
            ENET_SOCKET_SHUTDOWN_READ = 0,
            ENET_SOCKET_SHUTDOWN_WRITE = 1,
            ENET_SOCKET_SHUTDOWN_READ_WRITE = 2
        } ENetSocketShutdown; -}
#integral_t _ENetSocketShutdown
#num ENET_SOCKET_SHUTDOWN_READ
#num ENET_SOCKET_SHUTDOWN_WRITE
#num ENET_SOCKET_SHUTDOWN_READ_WRITE
#synonym_t ENetSocketShutdown , <_ENetSocketShutdown>
{- enum {
    ENET_HOST_ANY = 0,
    ENET_HOST_BROADCAST = 0xffffffff,
    ENET_PORT_ANY = 0
}; -}
#integral_t 
#num ENET_HOST_ANY
#num ENET_HOST_BROADCAST
#num ENET_PORT_ANY
{- typedef struct _ENetAddress {
            enet_uint32 host; enet_uint16 port;
        } ENetAddress; -}
#starttype _ENetAddress
#field host , Word32
#field port , Word16
#stoptype
#synonym_t ENetAddress , <_ENetAddress>
{- typedef enum _ENetPacketFlag {
            ENET_PACKET_FLAG_RELIABLE = 1 << 0,
            ENET_PACKET_FLAG_UNSEQUENCED = 1 << 1,
            ENET_PACKET_FLAG_NO_ALLOCATE = 1 << 2,
            ENET_PACKET_FLAG_UNRELIABLE_FRAGMENT = 1 << 3,
            ENET_PACKET_FLAG_SENT = 1 << 8
        } ENetPacketFlag; -}
#integral_t _ENetPacketFlag
#num ENET_PACKET_FLAG_RELIABLE
#num ENET_PACKET_FLAG_UNSEQUENCED
#num ENET_PACKET_FLAG_NO_ALLOCATE
#num ENET_PACKET_FLAG_UNRELIABLE_FRAGMENT
#num ENET_PACKET_FLAG_SENT
#synonym_t ENetPacketFlag , <_ENetPacketFlag>
{- typedef void (* ENetPacketFreeCallback)(struct _ENetPacket *); -}
{- typedef struct _ENetPacket {
            size_t referenceCount;
            enet_uint32 flags;
            enet_uint8 * data;
            size_t dataLength;
            ENetPacketFreeCallback freeCallback;
            void * userData;
        } ENetPacket; -}
#starttype _ENetPacket
#field referenceCount , CSize
#field flags , Word32
#field data , Ptr Word8
#field dataLength , CSize
#field freeCallback , <ENetPacketFreeCallback>
#field userData , Ptr ()
#stoptype
#synonym_t ENetPacket , <_ENetPacket>
{- typedef struct _ENetAcknowledgement {
            ENetListNode acknowledgementList;
            enet_uint32 sentTime;
            ENetProtocol command;
        } ENetAcknowledgement; -}
#starttype _ENetAcknowledgement
#field acknowledgementList , <_ENetListNode>
#field sentTime , Word32
#field command , <_ENetProtocol>
#stoptype
#synonym_t ENetAcknowledgement , <_ENetAcknowledgement>
{- typedef struct _ENetOutgoingCommand {
            ENetListNode outgoingCommandList;
            enet_uint16 reliableSequenceNumber;
            enet_uint16 unreliableSequenceNumber;
            enet_uint32 sentTime;
            enet_uint32 roundTripTimeout;
            enet_uint32 roundTripTimeoutLimit;
            enet_uint32 fragmentOffset;
            enet_uint16 fragmentLength;
            enet_uint16 sendAttempts;
            ENetProtocol command;
            ENetPacket * packet;
        } ENetOutgoingCommand; -}
#starttype _ENetOutgoingCommand
#field outgoingCommandList , <_ENetListNode>
#field reliableSequenceNumber , Word16
#field unreliableSequenceNumber , Word16
#field sentTime , Word32
#field roundTripTimeout , Word32
#field roundTripTimeoutLimit , Word32
#field fragmentOffset , Word32
#field fragmentLength , Word16
#field sendAttempts , Word16
#field command , <_ENetProtocol>
#field packet , Ptr <_ENetPacket>
#stoptype
#synonym_t ENetOutgoingCommand , <_ENetOutgoingCommand>
{- typedef struct _ENetIncomingCommand {
            ENetListNode incomingCommandList;
            enet_uint16 reliableSequenceNumber;
            enet_uint16 unreliableSequenceNumber;
            ENetProtocol command;
            enet_uint32 fragmentCount;
            enet_uint32 fragmentsRemaining;
            enet_uint32 * fragments;
            ENetPacket * packet;
        } ENetIncomingCommand; -}
#starttype _ENetIncomingCommand
#field incomingCommandList , <_ENetListNode>
#field reliableSequenceNumber , Word16
#field unreliableSequenceNumber , Word16
#field command , <_ENetProtocol>
#field fragmentCount , Word32
#field fragmentsRemaining , Word32
#field fragments , Ptr Word32
#field packet , Ptr <_ENetPacket>
#stoptype
#synonym_t ENetIncomingCommand , <_ENetIncomingCommand>
{- typedef enum _ENetPeerState {
            ENET_PEER_STATE_DISCONNECTED = 0,
            ENET_PEER_STATE_CONNECTING = 1,
            ENET_PEER_STATE_ACKNOWLEDGING_CONNECT = 2,
            ENET_PEER_STATE_CONNECTION_PENDING = 3,
            ENET_PEER_STATE_CONNECTION_SUCCEEDED = 4,
            ENET_PEER_STATE_CONNECTED = 5,
            ENET_PEER_STATE_DISCONNECT_LATER = 6,
            ENET_PEER_STATE_DISCONNECTING = 7,
            ENET_PEER_STATE_ACKNOWLEDGING_DISCONNECT = 8,
            ENET_PEER_STATE_ZOMBIE = 9
        } ENetPeerState; -}
#integral_t _ENetPeerState
#num ENET_PEER_STATE_DISCONNECTED
#num ENET_PEER_STATE_CONNECTING
#num ENET_PEER_STATE_ACKNOWLEDGING_CONNECT
#num ENET_PEER_STATE_CONNECTION_PENDING
#num ENET_PEER_STATE_CONNECTION_SUCCEEDED
#num ENET_PEER_STATE_CONNECTED
#num ENET_PEER_STATE_DISCONNECT_LATER
#num ENET_PEER_STATE_DISCONNECTING
#num ENET_PEER_STATE_ACKNOWLEDGING_DISCONNECT
#num ENET_PEER_STATE_ZOMBIE
#synonym_t ENetPeerState , <_ENetPeerState>
{- enum {
    ENET_HOST_RECEIVE_BUFFER_SIZE = 256 * 1024,
    ENET_HOST_SEND_BUFFER_SIZE = 256 * 1024,
    ENET_HOST_BANDWIDTH_THROTTLE_INTERVAL = 1000,
    ENET_HOST_DEFAULT_MTU = 1400,
    ENET_PEER_DEFAULT_ROUND_TRIP_TIME = 500,
    ENET_PEER_DEFAULT_PACKET_THROTTLE = 32,
    ENET_PEER_PACKET_THROTTLE_SCALE = 32,
    ENET_PEER_PACKET_THROTTLE_COUNTER = 7,
    ENET_PEER_PACKET_THROTTLE_ACCELERATION = 2,
    ENET_PEER_PACKET_THROTTLE_DECELERATION = 2,
    ENET_PEER_PACKET_THROTTLE_INTERVAL = 5000,
    ENET_PEER_PACKET_LOSS_SCALE = 1 << 16,
    ENET_PEER_PACKET_LOSS_INTERVAL = 10000,
    ENET_PEER_WINDOW_SIZE_SCALE = 64 * 1024,
    ENET_PEER_TIMEOUT_LIMIT = 32,
    ENET_PEER_TIMEOUT_MINIMUM = 5000,
    ENET_PEER_TIMEOUT_MAXIMUM = 30000,
    ENET_PEER_PING_INTERVAL = 500,
    ENET_PEER_UNSEQUENCED_WINDOWS = 64,
    ENET_PEER_UNSEQUENCED_WINDOW_SIZE = 1024,
    ENET_PEER_FREE_UNSEQUENCED_WINDOWS = 32,
    ENET_PEER_RELIABLE_WINDOWS = 16,
    ENET_PEER_RELIABLE_WINDOW_SIZE = 0x1000,
    ENET_PEER_FREE_RELIABLE_WINDOWS = 8
}; -}
#integral_t 
#num ENET_HOST_RECEIVE_BUFFER_SIZE
#num ENET_HOST_SEND_BUFFER_SIZE
#num ENET_HOST_BANDWIDTH_THROTTLE_INTERVAL
#num ENET_HOST_DEFAULT_MTU
#num ENET_PEER_DEFAULT_ROUND_TRIP_TIME
#num ENET_PEER_DEFAULT_PACKET_THROTTLE
#num ENET_PEER_PACKET_THROTTLE_SCALE
#num ENET_PEER_PACKET_THROTTLE_COUNTER
#num ENET_PEER_PACKET_THROTTLE_ACCELERATION
#num ENET_PEER_PACKET_THROTTLE_DECELERATION
#num ENET_PEER_PACKET_THROTTLE_INTERVAL
#num ENET_PEER_PACKET_LOSS_SCALE
#num ENET_PEER_PACKET_LOSS_INTERVAL
#num ENET_PEER_WINDOW_SIZE_SCALE
#num ENET_PEER_TIMEOUT_LIMIT
#num ENET_PEER_TIMEOUT_MINIMUM
#num ENET_PEER_TIMEOUT_MAXIMUM
#num ENET_PEER_PING_INTERVAL
#num ENET_PEER_UNSEQUENCED_WINDOWS
#num ENET_PEER_UNSEQUENCED_WINDOW_SIZE
#num ENET_PEER_FREE_UNSEQUENCED_WINDOWS
#num ENET_PEER_RELIABLE_WINDOWS
#num ENET_PEER_RELIABLE_WINDOW_SIZE
#num ENET_PEER_FREE_RELIABLE_WINDOWS
{- typedef struct _ENetChannel {
            enet_uint16 outgoingReliableSequenceNumber;
            enet_uint16 outgoingUnreliableSequenceNumber;
            enet_uint16 usedReliableWindows;
            enet_uint16 reliableWindows[ENET_PEER_RELIABLE_WINDOWS];
            enet_uint16 incomingReliableSequenceNumber;
            enet_uint16 incomingUnreliableSequenceNumber;
            ENetList incomingReliableCommands;
            ENetList incomingUnreliableCommands;
        } ENetChannel; -}
#starttype _ENetChannel
#field outgoingReliableSequenceNumber , Word16
#field outgoingUnreliableSequenceNumber , Word16
#field usedReliableWindows , Word16
#array_field reliableWindows , Word16
#field incomingReliableSequenceNumber , Word16
#field incomingUnreliableSequenceNumber , Word16
#field incomingReliableCommands , <_ENetList>
#field incomingUnreliableCommands , <_ENetList>
#stoptype
#synonym_t ENetChannel , <_ENetChannel>
{- typedef struct _ENetPeer {
            ENetListNode dispatchList;
            struct _ENetHost * host;
            enet_uint16 outgoingPeerID;
            enet_uint16 incomingPeerID;
            enet_uint32 connectID;
            enet_uint8 outgoingSessionID;
            enet_uint8 incomingSessionID;
            ENetAddress address;
            void * data;
            ENetPeerState state;
            ENetChannel * channels;
            size_t channelCount;
            enet_uint32 incomingBandwidth;
            enet_uint32 outgoingBandwidth;
            enet_uint32 incomingBandwidthThrottleEpoch;
            enet_uint32 outgoingBandwidthThrottleEpoch;
            enet_uint32 incomingDataTotal;
            enet_uint32 outgoingDataTotal;
            enet_uint32 lastSendTime;
            enet_uint32 lastReceiveTime;
            enet_uint32 nextTimeout;
            enet_uint32 earliestTimeout;
            enet_uint32 packetLossEpoch;
            enet_uint32 packetsSent;
            enet_uint32 packetsLost;
            enet_uint32 packetLoss;
            enet_uint32 packetLossVariance;
            enet_uint32 packetThrottle;
            enet_uint32 packetThrottleLimit;
            enet_uint32 packetThrottleCounter;
            enet_uint32 packetThrottleEpoch;
            enet_uint32 packetThrottleAcceleration;
            enet_uint32 packetThrottleDeceleration;
            enet_uint32 packetThrottleInterval;
            enet_uint32 pingInterval;
            enet_uint32 timeoutLimit;
            enet_uint32 timeoutMinimum;
            enet_uint32 timeoutMaximum;
            enet_uint32 lastRoundTripTime;
            enet_uint32 lowestRoundTripTime;
            enet_uint32 lastRoundTripTimeVariance;
            enet_uint32 highestRoundTripTimeVariance;
            enet_uint32 roundTripTime;
            enet_uint32 roundTripTimeVariance;
            enet_uint32 mtu;
            enet_uint32 windowSize;
            enet_uint32 reliableDataInTransit;
            enet_uint16 outgoingReliableSequenceNumber;
            ENetList acknowledgements;
            ENetList sentReliableCommands;
            ENetList sentUnreliableCommands;
            ENetList outgoingReliableCommands;
            ENetList outgoingUnreliableCommands;
            ENetList dispatchedCommands;
            int needsDispatch;
            enet_uint16 incomingUnsequencedGroup;
            enet_uint16 outgoingUnsequencedGroup;
            enet_uint32 unsequencedWindow[ENET_PEER_UNSEQUENCED_WINDOW_SIZE / 32];
            enet_uint32 eventData;
        } ENetPeer; -}
#starttype _ENetPeer
#field dispatchList , <_ENetListNode>
#field host , Ptr <_ENetHost>
#field outgoingPeerID , Word16
#field incomingPeerID , Word16
#field connectID , Word32
#field outgoingSessionID , Word8
#field incomingSessionID , Word8
#field address , <_ENetAddress>
#field data , Ptr ()
#field state , <_ENetPeerState>
#field channels , Ptr <_ENetChannel>
#field channelCount , CSize
#field incomingBandwidth , Word32
#field outgoingBandwidth , Word32
#field incomingBandwidthThrottleEpoch , Word32
#field outgoingBandwidthThrottleEpoch , Word32
#field incomingDataTotal , Word32
#field outgoingDataTotal , Word32
#field lastSendTime , Word32
#field lastReceiveTime , Word32
#field nextTimeout , Word32
#field earliestTimeout , Word32
#field packetLossEpoch , Word32
#field packetsSent , Word32
#field packetsLost , Word32
#field packetLoss , Word32
#field packetLossVariance , Word32
#field packetThrottle , Word32
#field packetThrottleLimit , Word32
#field packetThrottleCounter , Word32
#field packetThrottleEpoch , Word32
#field packetThrottleAcceleration , Word32
#field packetThrottleDeceleration , Word32
#field packetThrottleInterval , Word32
#field pingInterval , Word32
#field timeoutLimit , Word32
#field timeoutMinimum , Word32
#field timeoutMaximum , Word32
#field lastRoundTripTime , Word32
#field lowestRoundTripTime , Word32
#field lastRoundTripTimeVariance , Word32
#field highestRoundTripTimeVariance , Word32
#field roundTripTime , Word32
#field roundTripTimeVariance , Word32
#field mtu , Word32
#field windowSize , Word32
#field reliableDataInTransit , Word32
#field outgoingReliableSequenceNumber , Word16
#field acknowledgements , <_ENetList>
#field sentReliableCommands , <_ENetList>
#field sentUnreliableCommands , <_ENetList>
#field outgoingReliableCommands , <_ENetList>
#field outgoingUnreliableCommands , <_ENetList>
#field dispatchedCommands , <_ENetList>
#field needsDispatch , CInt
#field incomingUnsequencedGroup , Word16
#field outgoingUnsequencedGroup , Word16
#array_field unsequencedWindow , Word32
#field eventData , Word32
#stoptype
#synonym_t ENetPeer , <_ENetPeer>
{- typedef struct _ENetCompressor {
            void * context;
            size_t (* compress)(void * context,
                                const ENetBuffer * inBuffers,
                                size_t inBufferCount,
                                size_t inLimit,
                                enet_uint8 * outData,
                                size_t outLimit);
            size_t (* decompress)(void * context,
                                  const enet_uint8 * inData,
                                  size_t inLimit,
                                  enet_uint8 * outData,
                                  size_t outLimit);
            void (* destroy)(void * context);
        } ENetCompressor; -}
#starttype _ENetCompressor
#field context , Ptr ()
#field compress , FunPtr (Ptr () -> Ptr <ENetBuffer> -> CSize -> CSize -> Ptr Word8 -> CSize -> CSize)
#field decompress , FunPtr (Ptr () -> Ptr Word8 -> CSize -> Ptr Word8 -> CSize -> CSize)
#field destroy , FunPtr (Ptr () -> IO ())
#stoptype
#synonym_t ENetCompressor , <_ENetCompressor>
{- typedef enet_uint32 (* ENetChecksumCallback)(const ENetBuffer * buffers,
                                             size_t bufferCount); -}
#synonym_t ENetChecksumCallback , Word32
{- typedef int (* ENetInterceptCallback)(struct _ENetHost * host,
                                      struct _ENetEvent * event); -}
#synonym_t ENetInterceptCallback , CInt
{- typedef struct _ENetHost {
            ENetSocket socket;
            ENetAddress address;
            enet_uint32 incomingBandwidth;
            enet_uint32 outgoingBandwidth;
            enet_uint32 bandwidthThrottleEpoch;
            enet_uint32 mtu;
            enet_uint32 randomSeed;
            int recalculateBandwidthLimits;
            ENetPeer * peers;
            size_t peerCount;
            size_t channelLimit;
            enet_uint32 serviceTime;
            ENetList dispatchQueue;
            int continueSending;
            size_t packetSize;
            enet_uint16 headerFlags;
            ENetProtocol commands[ENET_PROTOCOL_MAXIMUM_PACKET_COMMANDS];
            size_t commandCount;
            ENetBuffer buffers[1 + 2 * ENET_PROTOCOL_MAXIMUM_PACKET_COMMANDS];
            size_t bufferCount;
            ENetChecksumCallback checksum;
            ENetCompressor compressor;
            enet_uint8 packetData[2][ENET_PROTOCOL_MAXIMUM_MTU];
            ENetAddress receivedAddress;
            enet_uint8 * receivedData;
            size_t receivedDataLength;
            enet_uint32 totalSentData;
            enet_uint32 totalSentPackets;
            enet_uint32 totalReceivedData;
            enet_uint32 totalReceivedPackets;
            ENetInterceptCallback intercept;
            size_t connectedPeers;
            size_t bandwidthLimitedPeers;
        } ENetHost; -}
#starttype _ENetHost
#field socket , CInt
#field address , <_ENetAddress>
#field incomingBandwidth , Word32
#field outgoingBandwidth , Word32
#field bandwidthThrottleEpoch , Word32
#field mtu , Word32
#field randomSeed , Word32
#field recalculateBandwidthLimits , CInt
#field peers , Ptr <_ENetPeer>
#field peerCount , CSize
#field channelLimit , CSize
#field serviceTime , Word32
#field dispatchQueue , <_ENetList>
#field continueSending , CInt
#field packetSize , CSize
#field headerFlags , Word16
#array_field commands , <_ENetProtocol>
#field commandCount , CSize
#array_field buffers , <ENetBuffer>
#field bufferCount , CSize
#field checksum , Word32
#field compressor , <_ENetCompressor>
#array_field packetData , Ptr (Word8)
#field receivedAddress , <_ENetAddress>
#field receivedData , Ptr Word8
#field receivedDataLength , CSize
#field totalSentData , Word32
#field totalSentPackets , Word32
#field totalReceivedData , Word32
#field totalReceivedPackets , Word32
#field intercept , CInt
#field connectedPeers , CSize
#field bandwidthLimitedPeers , CSize
#stoptype
#synonym_t ENetHost , <_ENetHost>
{- typedef enum _ENetEventType {
            ENET_EVENT_TYPE_NONE = 0,
            ENET_EVENT_TYPE_CONNECT = 1,
            ENET_EVENT_TYPE_DISCONNECT = 2,
            ENET_EVENT_TYPE_RECEIVE = 3
        } ENetEventType; -}
#integral_t _ENetEventType
#num ENET_EVENT_TYPE_NONE
#num ENET_EVENT_TYPE_CONNECT
#num ENET_EVENT_TYPE_DISCONNECT
#num ENET_EVENT_TYPE_RECEIVE
#synonym_t ENetEventType , <_ENetEventType>
{- typedef struct _ENetEvent {
            ENetEventType type;
            ENetPeer * peer;
            enet_uint8 channelID;
            enet_uint32 data;
            ENetPacket * packet;
        } ENetEvent; -}
#starttype _ENetEvent
#field type , <_ENetEventType>
#field peer , Ptr <_ENetPeer>
#field channelID , Word8
#field data , Word32
#field packet , Ptr <_ENetPacket>
#stoptype
#synonym_t ENetEvent , <_ENetEvent>
#ccall enet_initialize , IO (CInt)
#ccall enet_initialize_with_callbacks , Word32 -> Ptr <_ENetCallbacks> -> IO (CInt)
#ccall enet_deinitialize , IO ()
#ccall enet_linked_version , IO (Word32)
#ccall enet_time_get , IO (Word32)
#ccall enet_time_set , Word32 -> IO ()
#ccall enet_socket_create , <_ENetSocketType> -> IO (CInt)
#ccall enet_socket_bind , CInt -> Ptr <_ENetAddress> -> IO (CInt)
#ccall enet_socket_get_address , CInt -> Ptr <_ENetAddress> -> IO (CInt)
#ccall enet_socket_listen , CInt -> CInt -> IO (CInt)
#ccall enet_socket_accept , CInt -> Ptr <_ENetAddress> -> IO (CInt)
#ccall enet_socket_connect , CInt -> Ptr <_ENetAddress> -> IO (CInt)
#ccall enet_socket_send , CInt -> Ptr <_ENetAddress> -> Ptr <ENetBuffer> -> CSize -> IO (CInt)
#ccall enet_socket_receive , CInt -> Ptr <_ENetAddress> -> Ptr <ENetBuffer> -> CSize -> IO (CInt)
#ccall enet_socket_wait , CInt -> Ptr Word32 -> Word32 -> IO (CInt)
#ccall enet_socket_set_option , CInt -> <_ENetSocketOption> -> CInt -> IO (CInt)
#ccall enet_socket_shutdown , CInt -> <_ENetSocketShutdown> -> IO (CInt)
#ccall enet_socket_destroy , CInt -> IO ()
#ccall enet_socketset_select , CInt -> Ptr <fd_set> -> Ptr <fd_set> -> Word32 -> IO (CInt)
#ccall enet_address_set_host , Ptr <_ENetAddress> -> CString -> IO (CInt)
#ccall enet_address_get_host_ip , Ptr <_ENetAddress> -> CString -> CSize -> IO (CInt)
#ccall enet_address_get_host , Ptr <_ENetAddress> -> CString -> CSize -> IO (CInt)
#ccall enet_packet_create , Ptr () -> CSize -> Word32 -> IO (Ptr <_ENetPacket>)
#ccall enet_packet_destroy , Ptr <_ENetPacket> -> IO ()
#ccall enet_packet_resize , Ptr <_ENetPacket> -> CSize -> IO (CInt)
#ccall enet_crc32 , Ptr <ENetBuffer> -> CSize -> IO (Word32)
#ccall enet_host_create , Ptr <_ENetAddress> -> CSize -> CSize -> Word32 -> Word32 -> IO (Ptr <_ENetHost>)
#ccall enet_host_destroy , Ptr <_ENetHost> -> IO ()
#ccall enet_host_connect , Ptr <_ENetHost> -> Ptr <_ENetAddress> -> CSize -> Word32 -> IO (Ptr <_ENetPeer>)
#ccall enet_host_check_events , Ptr <_ENetHost> -> Ptr <_ENetEvent> -> IO (CInt)
#ccall enet_host_service , Ptr <_ENetHost> -> Ptr <_ENetEvent> -> Word32 -> IO (CInt)
#ccall enet_host_flush , Ptr <_ENetHost> -> IO ()
#ccall enet_host_broadcast , Ptr <_ENetHost> -> Word8 -> Ptr <_ENetPacket> -> IO ()
#ccall enet_host_compress , Ptr <_ENetHost> -> Ptr <_ENetCompressor> -> IO ()
#ccall enet_host_compress_with_range_coder , Ptr <_ENetHost> -> IO (CInt)
#ccall enet_host_channel_limit , Ptr <_ENetHost> -> CSize -> IO ()
#ccall enet_host_bandwidth_limit , Ptr <_ENetHost> -> Word32 -> Word32 -> IO ()
#ccall enet_host_bandwidth_throttle , Ptr <_ENetHost> -> IO ()
#ccall enet_peer_send , Ptr <_ENetPeer> -> Word8 -> Ptr <_ENetPacket> -> IO (CInt)
#ccall enet_peer_receive , Ptr <_ENetPeer> -> Ptr Word8 -> IO (Ptr <_ENetPacket>)
#ccall enet_peer_ping , Ptr <_ENetPeer> -> IO ()
#ccall enet_peer_ping_interval , Ptr <_ENetPeer> -> Word32 -> IO ()
#ccall enet_peer_timeout , Ptr <_ENetPeer> -> Word32 -> Word32 -> Word32 -> IO ()
#ccall enet_peer_reset , Ptr <_ENetPeer> -> IO ()
#ccall enet_peer_disconnect , Ptr <_ENetPeer> -> Word32 -> IO ()
#ccall enet_peer_disconnect_now , Ptr <_ENetPeer> -> Word32 -> IO ()
#ccall enet_peer_disconnect_later , Ptr <_ENetPeer> -> Word32 -> IO ()
#ccall enet_peer_throttle_configure , Ptr <_ENetPeer> -> Word32 -> Word32 -> Word32 -> IO ()
#ccall enet_peer_throttle , Ptr <_ENetPeer> -> Word32 -> IO (CInt)
#ccall enet_peer_reset_queues , Ptr <_ENetPeer> -> IO ()
#ccall enet_peer_setup_outgoing_command , Ptr <_ENetPeer> -> Ptr <_ENetOutgoingCommand> -> IO ()
#ccall enet_peer_queue_outgoing_command , Ptr <_ENetPeer> -> Ptr <_ENetProtocol> -> Ptr <_ENetPacket> -> Word32 -> Word16 -> IO (Ptr <_ENetOutgoingCommand>)
#ccall enet_peer_queue_incoming_command , Ptr <_ENetPeer> -> Ptr <_ENetProtocol> -> Ptr <_ENetPacket> -> Word32 -> IO (Ptr <_ENetIncomingCommand>)
#ccall enet_peer_queue_acknowledgement , Ptr <_ENetPeer> -> Ptr <_ENetProtocol> -> Word16 -> IO (Ptr <_ENetAcknowledgement>)
#ccall enet_peer_dispatch_incoming_unreliable_commands , Ptr <_ENetPeer> -> Ptr <_ENetChannel> -> IO ()
#ccall enet_peer_dispatch_incoming_reliable_commands , Ptr <_ENetPeer> -> Ptr <_ENetChannel> -> IO ()
#ccall enet_peer_on_connect , Ptr <_ENetPeer> -> IO ()
#ccall enet_peer_on_disconnect , Ptr <_ENetPeer> -> IO ()
#ccall enet_range_coder_create , IO (Ptr ())
#ccall enet_range_coder_destroy , Ptr () -> IO ()
#ccall enet_range_coder_compress , Ptr () -> Ptr <ENetBuffer> -> CSize -> CSize -> Ptr Word8 -> CSize -> IO (CSize)
#ccall enet_range_coder_decompress , Ptr () -> Ptr Word8 -> CSize -> Ptr Word8 -> CSize -> IO (CSize)
#ccall enet_protocol_command_size , Word8 -> IO (CSize)
