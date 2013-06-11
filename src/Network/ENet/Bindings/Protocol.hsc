{-# OPTIONS_GHC -fno-warn-unused-imports #-}
#include <bindings.dsl.h>
#include "enet/include/enet/protocol.h"
module Network.ENet.Bindings.Protocol where
import Foreign.Ptr
#strict_import

import Network.ENet.Bindings.Types
{- enum {
    ENET_PROTOCOL_MINIMUM_MTU = 576,
    ENET_PROTOCOL_MAXIMUM_MTU = 4096,
    ENET_PROTOCOL_MAXIMUM_PACKET_COMMANDS = 32,
    ENET_PROTOCOL_MINIMUM_WINDOW_SIZE = 4096,
    ENET_PROTOCOL_MAXIMUM_WINDOW_SIZE = 32768,
    ENET_PROTOCOL_MINIMUM_CHANNEL_COUNT = 1,
    ENET_PROTOCOL_MAXIMUM_CHANNEL_COUNT = 255,
    ENET_PROTOCOL_MAXIMUM_PEER_ID = 0xfff,
    ENET_PROTOCOL_MAXIMUM_PACKET_SIZE = 1024 * 1024 * 1024,
    ENET_PROTOCOL_MAXIMUM_FRAGMENT_COUNT = 1024 * 1024
}; -}
#integral_t 
#num ENET_PROTOCOL_MINIMUM_MTU
#num ENET_PROTOCOL_MAXIMUM_MTU
#num ENET_PROTOCOL_MAXIMUM_PACKET_COMMANDS
#num ENET_PROTOCOL_MINIMUM_WINDOW_SIZE
#num ENET_PROTOCOL_MAXIMUM_WINDOW_SIZE
#num ENET_PROTOCOL_MINIMUM_CHANNEL_COUNT
#num ENET_PROTOCOL_MAXIMUM_CHANNEL_COUNT
#num ENET_PROTOCOL_MAXIMUM_PEER_ID
#num ENET_PROTOCOL_MAXIMUM_PACKET_SIZE
#num ENET_PROTOCOL_MAXIMUM_FRAGMENT_COUNT
{- typedef enum _ENetProtocolCommand {
            ENET_PROTOCOL_COMMAND_NONE = 0,
            ENET_PROTOCOL_COMMAND_ACKNOWLEDGE = 1,
            ENET_PROTOCOL_COMMAND_CONNECT = 2,
            ENET_PROTOCOL_COMMAND_VERIFY_CONNECT = 3,
            ENET_PROTOCOL_COMMAND_DISCONNECT = 4,
            ENET_PROTOCOL_COMMAND_PING = 5,
            ENET_PROTOCOL_COMMAND_SEND_RELIABLE = 6,
            ENET_PROTOCOL_COMMAND_SEND_UNRELIABLE = 7,
            ENET_PROTOCOL_COMMAND_SEND_FRAGMENT = 8,
            ENET_PROTOCOL_COMMAND_SEND_UNSEQUENCED = 9,
            ENET_PROTOCOL_COMMAND_BANDWIDTH_LIMIT = 10,
            ENET_PROTOCOL_COMMAND_THROTTLE_CONFIGURE = 11,
            ENET_PROTOCOL_COMMAND_SEND_UNRELIABLE_FRAGMENT = 12,
            ENET_PROTOCOL_COMMAND_COUNT = 13,
            ENET_PROTOCOL_COMMAND_MASK = 0xf
        } ENetProtocolCommand; -}
#integral_t _ENetProtocolCommand
#num ENET_PROTOCOL_COMMAND_NONE
#num ENET_PROTOCOL_COMMAND_ACKNOWLEDGE
#num ENET_PROTOCOL_COMMAND_CONNECT
#num ENET_PROTOCOL_COMMAND_VERIFY_CONNECT
#num ENET_PROTOCOL_COMMAND_DISCONNECT
#num ENET_PROTOCOL_COMMAND_PING
#num ENET_PROTOCOL_COMMAND_SEND_RELIABLE
#num ENET_PROTOCOL_COMMAND_SEND_UNRELIABLE
#num ENET_PROTOCOL_COMMAND_SEND_FRAGMENT
#num ENET_PROTOCOL_COMMAND_SEND_UNSEQUENCED
#num ENET_PROTOCOL_COMMAND_BANDWIDTH_LIMIT
#num ENET_PROTOCOL_COMMAND_THROTTLE_CONFIGURE
#num ENET_PROTOCOL_COMMAND_SEND_UNRELIABLE_FRAGMENT
#num ENET_PROTOCOL_COMMAND_COUNT
#num ENET_PROTOCOL_COMMAND_MASK
#synonym_t ENetProtocolCommand , <_ENetProtocolCommand>
{- typedef enum _ENetProtocolFlag {
            ENET_PROTOCOL_COMMAND_FLAG_ACKNOWLEDGE = 1 << 7,
            ENET_PROTOCOL_COMMAND_FLAG_UNSEQUENCED = 1 << 6,
            ENET_PROTOCOL_HEADER_FLAG_COMPRESSED = 1 << 14,
            ENET_PROTOCOL_HEADER_FLAG_SENT_TIME = 1 << 15,
            ENET_PROTOCOL_HEADER_FLAG_MASK = ENET_PROTOCOL_HEADER_FLAG_COMPRESSED | ENET_PROTOCOL_HEADER_FLAG_SENT_TIME,
            ENET_PROTOCOL_HEADER_SESSION_MASK = 3 << 12,
            ENET_PROTOCOL_HEADER_SESSION_SHIFT = 12
        } ENetProtocolFlag; -}
#integral_t _ENetProtocolFlag
#num ENET_PROTOCOL_COMMAND_FLAG_ACKNOWLEDGE
#num ENET_PROTOCOL_COMMAND_FLAG_UNSEQUENCED
#num ENET_PROTOCOL_HEADER_FLAG_COMPRESSED
#num ENET_PROTOCOL_HEADER_FLAG_SENT_TIME
#num ENET_PROTOCOL_HEADER_FLAG_MASK
#num ENET_PROTOCOL_HEADER_SESSION_MASK
#num ENET_PROTOCOL_HEADER_SESSION_SHIFT
#synonym_t ENetProtocolFlag , <_ENetProtocolFlag>
{- typedef struct __attribute__((packed)) _ENetProtocolHeader {
            enet_uint16 peerID; enet_uint16 sentTime;
        } ENetProtocolHeader; -}
#starttype _ENetProtocolHeader
#field peerID , CUShort
#field sentTime , CUShort
#stoptype
#synonym_t ENetProtocolHeader , <_ENetProtocolHeader>
{- typedef struct __attribute__((packed)) _ENetProtocolCommandHeader {
            enet_uint8 command;
            enet_uint8 channelID;
            enet_uint16 reliableSequenceNumber;
        } ENetProtocolCommandHeader; -}
#starttype _ENetProtocolCommandHeader
#field command , CUChar
#field channelID , CUChar
#field reliableSequenceNumber , CUShort
#stoptype
#synonym_t ENetProtocolCommandHeader , <_ENetProtocolCommandHeader>
{- typedef struct __attribute__((packed)) _ENetProtocolAcknowledge {
            ENetProtocolCommandHeader header;
            enet_uint16 receivedReliableSequenceNumber;
            enet_uint16 receivedSentTime;
        } ENetProtocolAcknowledge; -}
#starttype _ENetProtocolAcknowledge
#field header , <_ENetProtocolCommandHeader>
#field receivedReliableSequenceNumber , CUShort
#field receivedSentTime , CUShort
#stoptype
#synonym_t ENetProtocolAcknowledge , <_ENetProtocolAcknowledge>
{- typedef struct __attribute__((packed)) _ENetProtocolConnect {
            ENetProtocolCommandHeader header;
            enet_uint16 outgoingPeerID;
            enet_uint8 incomingSessionID;
            enet_uint8 outgoingSessionID;
            enet_uint32 mtu;
            enet_uint32 windowSize;
            enet_uint32 channelCount;
            enet_uint32 incomingBandwidth;
            enet_uint32 outgoingBandwidth;
            enet_uint32 packetThrottleInterval;
            enet_uint32 packetThrottleAcceleration;
            enet_uint32 packetThrottleDeceleration;
            enet_uint32 connectID;
            enet_uint32 data;
        } ENetProtocolConnect; -}
#starttype _ENetProtocolConnect
#field header , <_ENetProtocolCommandHeader>
#field outgoingPeerID , CUShort
#field incomingSessionID , CUChar
#field outgoingSessionID , CUChar
#field mtu , CUInt
#field windowSize , CUInt
#field channelCount , CUInt
#field incomingBandwidth , CUInt
#field outgoingBandwidth , CUInt
#field packetThrottleInterval , CUInt
#field packetThrottleAcceleration , CUInt
#field packetThrottleDeceleration , CUInt
#field connectID , CUInt
#field data , CUInt
#stoptype
#synonym_t ENetProtocolConnect , <_ENetProtocolConnect>
{- typedef struct __attribute__((packed)) _ENetProtocolVerifyConnect {
            ENetProtocolCommandHeader header;
            enet_uint16 outgoingPeerID;
            enet_uint8 incomingSessionID;
            enet_uint8 outgoingSessionID;
            enet_uint32 mtu;
            enet_uint32 windowSize;
            enet_uint32 channelCount;
            enet_uint32 incomingBandwidth;
            enet_uint32 outgoingBandwidth;
            enet_uint32 packetThrottleInterval;
            enet_uint32 packetThrottleAcceleration;
            enet_uint32 packetThrottleDeceleration;
            enet_uint32 connectID;
        } ENetProtocolVerifyConnect; -}
#starttype _ENetProtocolVerifyConnect
#field header , <_ENetProtocolCommandHeader>
#field outgoingPeerID , CUShort
#field incomingSessionID , CUChar
#field outgoingSessionID , CUChar
#field mtu , CUInt
#field windowSize , CUInt
#field channelCount , CUInt
#field incomingBandwidth , CUInt
#field outgoingBandwidth , CUInt
#field packetThrottleInterval , CUInt
#field packetThrottleAcceleration , CUInt
#field packetThrottleDeceleration , CUInt
#field connectID , CUInt
#stoptype
#synonym_t ENetProtocolVerifyConnect , <_ENetProtocolVerifyConnect>
{- typedef struct __attribute__((packed)) _ENetProtocolBandwidthLimit {
            ENetProtocolCommandHeader header;
            enet_uint32 incomingBandwidth;
            enet_uint32 outgoingBandwidth;
        } ENetProtocolBandwidthLimit; -}
#starttype _ENetProtocolBandwidthLimit
#field header , <_ENetProtocolCommandHeader>
#field incomingBandwidth , CUInt
#field outgoingBandwidth , CUInt
#stoptype
#synonym_t ENetProtocolBandwidthLimit , <_ENetProtocolBandwidthLimit>
{- typedef struct __attribute__((packed)) _ENetProtocolThrottleConfigure {
            ENetProtocolCommandHeader header;
            enet_uint32 packetThrottleInterval;
            enet_uint32 packetThrottleAcceleration;
            enet_uint32 packetThrottleDeceleration;
        } ENetProtocolThrottleConfigure; -}
#starttype _ENetProtocolThrottleConfigure
#field header , <_ENetProtocolCommandHeader>
#field packetThrottleInterval , CUInt
#field packetThrottleAcceleration , CUInt
#field packetThrottleDeceleration , CUInt
#stoptype
#synonym_t ENetProtocolThrottleConfigure , <_ENetProtocolThrottleConfigure>
{- typedef struct __attribute__((packed)) _ENetProtocolDisconnect {
            ENetProtocolCommandHeader header; enet_uint32 data;
        } ENetProtocolDisconnect; -}
#starttype _ENetProtocolDisconnect
#field header , <_ENetProtocolCommandHeader>
#field data , CUInt
#stoptype
#synonym_t ENetProtocolDisconnect , <_ENetProtocolDisconnect>
{- typedef struct __attribute__((packed)) _ENetProtocolPing {
            ENetProtocolCommandHeader header;
        } ENetProtocolPing; -}
#starttype _ENetProtocolPing
#field header , <_ENetProtocolCommandHeader>
#stoptype
#synonym_t ENetProtocolPing , <_ENetProtocolPing>
{- typedef struct __attribute__((packed)) _ENetProtocolSendReliable {
            ENetProtocolCommandHeader header; enet_uint16 dataLength;
        } ENetProtocolSendReliable; -}
#starttype _ENetProtocolSendReliable
#field header , <_ENetProtocolCommandHeader>
#field dataLength , CUShort
#stoptype
#synonym_t ENetProtocolSendReliable , <_ENetProtocolSendReliable>
{- typedef struct __attribute__((packed)) _ENetProtocolSendUnreliable {
            ENetProtocolCommandHeader header;
            enet_uint16 unreliableSequenceNumber;
            enet_uint16 dataLength;
        } ENetProtocolSendUnreliable; -}
#starttype _ENetProtocolSendUnreliable
#field header , <_ENetProtocolCommandHeader>
#field unreliableSequenceNumber , CUShort
#field dataLength , CUShort
#stoptype
#synonym_t ENetProtocolSendUnreliable , <_ENetProtocolSendUnreliable>
{- typedef struct __attribute__((packed)) _ENetProtocolSendUnsequenced {
            ENetProtocolCommandHeader header;
            enet_uint16 unsequencedGroup;
            enet_uint16 dataLength;
        } ENetProtocolSendUnsequenced; -}
#starttype _ENetProtocolSendUnsequenced
#field header , <_ENetProtocolCommandHeader>
#field unsequencedGroup , CUShort
#field dataLength , CUShort
#stoptype
#synonym_t ENetProtocolSendUnsequenced , <_ENetProtocolSendUnsequenced>
{- typedef struct __attribute__((packed)) _ENetProtocolSendFragment {
            ENetProtocolCommandHeader header;
            enet_uint16 startSequenceNumber;
            enet_uint16 dataLength;
            enet_uint32 fragmentCount;
            enet_uint32 fragmentNumber;
            enet_uint32 totalLength;
            enet_uint32 fragmentOffset;
        } ENetProtocolSendFragment; -}
#starttype _ENetProtocolSendFragment
#field header , <_ENetProtocolCommandHeader>
#field startSequenceNumber , CUShort
#field dataLength , CUShort
#field fragmentCount , CUInt
#field fragmentNumber , CUInt
#field totalLength , CUInt
#field fragmentOffset , CUInt
#stoptype
#synonym_t ENetProtocolSendFragment , <_ENetProtocolSendFragment>
{- typedef union __attribute__((packed)) _ENetProtocol {
            ENetProtocolCommandHeader header;
            ENetProtocolAcknowledge acknowledge;
            ENetProtocolConnect connect;
            ENetProtocolVerifyConnect verifyConnect;
            ENetProtocolDisconnect disconnect;
            ENetProtocolPing ping;
            ENetProtocolSendReliable sendReliable;
            ENetProtocolSendUnreliable sendUnreliable;
            ENetProtocolSendUnsequenced sendUnsequenced;
            ENetProtocolSendFragment sendFragment;
            ENetProtocolBandwidthLimit bandwidthLimit;
            ENetProtocolThrottleConfigure throttleConfigure;
        } ENetProtocol; -}
#starttype _ENetProtocol
#field header , <_ENetProtocolCommandHeader>
#field acknowledge , <_ENetProtocolAcknowledge>
#field connect , <_ENetProtocolConnect>
#field verifyConnect , <_ENetProtocolVerifyConnect>
#field disconnect , <_ENetProtocolDisconnect>
#field ping , <_ENetProtocolPing>
#field sendReliable , <_ENetProtocolSendReliable>
#field sendUnreliable , <_ENetProtocolSendUnreliable>
#field sendUnsequenced , <_ENetProtocolSendUnsequenced>
#field sendFragment , <_ENetProtocolSendFragment>
#field bandwidthLimit , <_ENetProtocolBandwidthLimit>
#field throttleConfigure , <_ENetProtocolThrottleConfigure>
#stoptype
#synonym_t ENetProtocol , <_ENetProtocol>
