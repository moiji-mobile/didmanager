forward
localViaFor: aRequest
	| branch newBranch |
	branch := (aRequest parameter: 'Via' ifAbsent: [nil]) branch.
	newBranch := 'z9hG4bK', (SHA1 hashMessage: branch, branchSeed) hex.
	^String streamContents: [:str |
		str
			nextPutAll: 'SIP/2.0/UDP ';
			nextPutAll: localSipHostname;
			nextPut: $:;
			nextPutAll: localSipPort asString;
			nextPutAll: ';branch=';
			nextPutAll: newBranch
	]