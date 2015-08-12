private for testing
localTransport: aTransport
	localUdpTransport := aTransport.
	localUdpTransport handler: self.