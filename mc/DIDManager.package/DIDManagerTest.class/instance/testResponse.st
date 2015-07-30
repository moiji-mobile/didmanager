as yet unclassified
testResponse
	| datagram |
	datagram := OsmoUDPDatagram new.
	datagram
		port: 6666;
		address: #[6 6 6 6];
		data: self class exampleResponse;
		yourself.
	didManager handleDataInternal: datagram transport: nil.
	self assert: didManager dialogues size equals: 1.