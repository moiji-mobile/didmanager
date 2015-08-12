as yet unclassified
testResponse
	| datagram data |
	
	"Verify a response is routed back"

	data := OrderedCollection new.
	localMock onData: [:msg |
		 data add: msg].

	datagram := OsmoUDPDatagram new.
	datagram
		port: 6666;
		address: #[6 6 6 6];
		data: self class exampleResponse;
		yourself.
	didManager handleDataInternal: datagram transport: remoteMock.

	self assert: data size equals: 1.
	self assert: data first port equals: 5063.