as yet unclassified
testBrokenMeraACK
	| datagram data |
	
	"This tests that beside the mera system not including the route headers
	we know where to route the bye to."

	data := OrderedCollection new.
	remoteMock onData: [:msg |
		 data add: msg].

	route msisdn: '447418506491'.

	datagram := OsmoUDPDatagram new.
	datagram
		port: 6666;
		address: #[6 6 6 6];
		data: self class brokenMeraACK;
		yourself.
	didManager handleDataInternal: datagram transport: localMock.

	"Check it is one message we forwarded"
	self assert: data size equals: 1.
	self assert: data first data asByteArray equals: self class meraRoutedAckExpectation.