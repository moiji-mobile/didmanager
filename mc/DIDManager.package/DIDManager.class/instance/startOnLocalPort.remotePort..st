as yet unclassified
startOnLocalPort: aLocalPort remotePort: aRemotePort
	localSipPort := aLocalPort.
	remoteSipPort := aRemotePort.
	localUdpTransport := SIPUdpTransport startOn: nil port: aLocalPort.
	localUdpTransport handler: self.
	remoteUdpTransport := SIPUdpTransport startOn: nil port: aRemotePort.
	remoteUdpTransport handler: self.


	localUdpTransport start.
	remoteUdpTransport start.