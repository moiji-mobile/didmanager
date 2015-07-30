forward
remoteRecordRoute
	^String streamContents: [:str |
		str
			nextPutAll: '<sip:';
			nextPutAll: remoteSipHostname;
			nextPut: $:;
			nextPutAll: remoteSipPort asString;
			nextPutAll: ';lr>'
	]