forward
localRecordRoute
	^String streamContents: [:str |
		str
			nextPutAll: '<sip:';
			nextPutAll: localSipHostname;
			nextPut: $:;
			nextPutAll: localSipPort asString;
			nextPutAll: ';lr>'
	]