as yet unclassified
testBrokenMeraACK
	| datagram data |
	
	"This tests an ACK for a 503 not having any routes set and requires us
	to route it based on the TO address again"

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