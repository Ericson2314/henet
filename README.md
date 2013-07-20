hENet
================================================================================

ENet is a networking library on top of UDP. In it's own words:

  ENet's purpose is to provide a relatively thin, simple and robust network
  communication layer on top of UDP (User Datagram Protocol). The primary
  feature it provides is optional reliable, in-order delivery of packets.

  ENet omits certain higher level networking features such as authentication,
  lobbying, server discovery, encryption, or other similar tasks that are
  particularly application specific so that the library remains flexible,
  portable, and easily embeddable.

This library contains both bindings and a slightly cleaned up interface on
top. The bindings are as close to the original as possible. Names are striped of
the leading `enet_` and converted to CamelCase, and the occasional newtype is
used instead, but otherwise all functions signatures are exactly the same. The
bindings are in `Network.ENet.Bindings`.

The higher level interface is all other exposed modules. Functions like
`enet_host_*` are placed in `Network.ENet.Host`. All functions are present
except for the `enet_socket*` functions: they are just wrappers of the Posix
Sockets Interface, which is already provided in Haskell by the `network`
package. Changes are fairly minimal: "Out-Args" are now returned with a tuple,
conversions between C and Haskell types happen automatically (when Haskell
versions exists), and nullable pointer types have been replaced with Maybes. In
short, there should be very few reasons to use the raw bindings over the "nice"
interface.

At the moment, consult the ENet website for documentation. In the vast majority
of cases the documentation there should apply here exactly, I will try to add
Haddock documentation for everywhere it does not.

ENet currently only supports IPv4 at the moment (though that should soon
change), and is only safe to use as when used in one thread. Richer native
networking libraries leveraging Haskell's strengths exist, and for new projects
I'd recommend those. But for interfacing with existing protocols using ENet,
this package should be quite useful.

Links
--------------------------------------------------------------------------------

 - ENet website: http://enet.bespin.org
 - ENet source: https://github.com/lsalzman/enet
