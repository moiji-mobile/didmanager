as yet unclassified
startOnLocalPort: aLocalPort remotePort: aRemotePort
	| localTransport remoteTransport |

	localTransport := SIPUdpTransport startOn: nil port: aLocalPort.
	remoteTransport := SIPUdpTransport startOn: nil port: aRemotePort.

	self localTransport: localTransport port: aLocalPort.
	self remoteTransport: remoteTransport port: aRemotePort.

	localUdpTransport handler: self.
	remoteUdpTransport handler: self.

	localUdpTransport start.
	remoteUdpTransport start.
	
	aLocalPort inspect.