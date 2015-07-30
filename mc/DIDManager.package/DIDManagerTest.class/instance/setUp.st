as yet unclassified
setUp
	didManager := DIDManager new.
	didManager localSipHostname: '127.0.0.1'.
	didManager remoteSipHostname: '127.0.0.1'.
	didManager localSipPort: 5066.
	didManager remoteSipPort: 5067.
	didManager privBranchSeed: 'a483c4f6'.