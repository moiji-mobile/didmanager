forward
remoteViaFor: aRequest
	| branch newBranch |
	branch := (aRequest parameter: 'Via' ifAbsent: [nil]) branch.
	newBranch := 'z9hG4bK', (SHA1 hashMessage: branch, branchSeed) hex.
	^String streamContents: [:str |
		str
			nextPutAll: 'SIP/2.0/UDP ';
			nextPutAll: remoteSipHostname;
			nextPut: $:;
			nextPutAll: remoteSipPort asString;
			nextPutAll: ';branch=';
			nextPutAll: newBranch
	]