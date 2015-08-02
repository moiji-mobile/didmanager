as yet unclassified
setUp
	| route customer db |
	didManager := DIDManager new.
	didManager localSipHostname: '127.0.0.1'.
	didManager remoteSipHostname: '127.0.0.1'.
	didManager localSipPort: 5066.
	didManager remoteSipPort: 5067.
	didManager privBranchSeed: 'a483c4f6'.

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