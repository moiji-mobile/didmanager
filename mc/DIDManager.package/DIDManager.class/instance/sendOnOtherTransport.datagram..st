as yet unclassified
sendOnOtherTransport: aTransport datagram: datagram 
	(aTransport == localUdpTransport
		ifTrue: [remoteUdpTransport]
		ifFalse: [localUdpTransport]) queueDatagram: datagram.