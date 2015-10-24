as yet unclassified
setUp
	| customer db |

	localMock := SIPTransportMock new.
	remoteMock := SIPTransportMock new.

	didManager := DIDManager new.
	didManager localSipHostname: '127.0.0.1'.
	didManager remoteSipHostname: '127.0.0.1'.

	didManager privBranchSeed: 'a483c4f6'.
	didManager localTransport: localMock port: 5066.
	didManager remoteTransport: remoteMock port: 5067.
	localMock handler: didManager.
	remoteMock handler: didManager.

	customer := SMPPMongoDIDCustomer new
					sipProxyIP: '127.0.0.2';
					sipProxyPort: 5068;
					customerName: 'bla';
					yourself.
	route := SMPPMongoRoute new
				customer: customer;
				msisdn: '447418506490';
				yourself.
	db := VOMemoryRepository new.
	db save: route.
	didManager database: db. 