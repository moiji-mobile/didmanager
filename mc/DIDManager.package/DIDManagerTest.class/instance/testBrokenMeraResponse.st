as yet unclassified
testBrokenMeraResponse
	| datagram data |
	
	"This tests that beside the mera system not including the route headers
	we know where to route the bye to."

	data := OrderedCollection new.
	remoteMock onData: [:msg |
		 data add: msg].

	datagram := OsmoUDPDatagram new.
	datagram
		port: 6666;
		address: #[6 6 6 6];
		data: self class brokenResponse;
		yourself.
	didManager database: nil.
	didManager handleDataInternal: datagram transport: localMock.

	"Check it is one message we forwarded"
	self assert: data size equals: 1.
	self flag: #todo. "Verify that our  Record-Route is inserted again"