as yet unclassified
testInvite
	| datagram |
	datagram := OsmoUDPDatagram new.
	datagram
		port: 6666;
		address: #[6 6 6 6];
		data: self class exampleInvite;
		yourself.
	didManager handleDataInternal: datagram transport: nil.
	self assert: didManager dialogues size equals: 1.