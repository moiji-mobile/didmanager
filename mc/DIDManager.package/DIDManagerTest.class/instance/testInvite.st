as yet unclassified
testInvite
	| datagram data |
	
	"We want the invite to go from the local to the remote side"

	data := OrderedCollection new.
	remoteMock onData: [:msg |
		 data add: msg].

	datagram := OsmoUDPDatagram new.
	datagram
		port: 6666;
		address: #[6 6 6 6];
		data: self class exampleInvite;
		yourself.
	didManager handleDataInternal: datagram transport: localMock.

	"Check it is one message we forwarded"
	self assert: data size equals: 1.
	self flag: #todo. "Verify that our Via's and Record-Route were inserted.."