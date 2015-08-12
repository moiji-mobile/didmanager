as yet unclassified
testAck
	| datagram data |
	
	"We want to route the ACK for a 200 back to the remote side. Check
	it is leaving on the right interface."
	data := OrderedCollection new.
	remoteMock onData: [:msg |
		 data add: msg].

	datagram := OsmoUDPDatagram new.
	datagram
		port: 6666;
		address: #[6 6 6 6];
		data: self class exampleAck;
		yourself.

	didManager database: nil.
	didManager handleDataInternal: datagram transport: localMock.

	self assert: data size equals: 1.
	self flag: #todo. "Verify that we add record-routes again"