as yet unclassified
sendOnOtherTransport: aTransport datagram: datagram
	(aTransport == localUdpTransport
		ifTrue: [remoteUdpTransport]
		ifFalse: [localUdpTransport]) sendDatagram: datagram.
	statsdClient increment: 'did.net.sent' rate: 1.