as yet unclassified
buildRecordRoute: aSystem 
	^String streamContents: [:str |
		str
			nextPutAll: '<sip:';
			nextPutAll: aSystem sipProxyIP;
			nextPut: $:;
			nextPutAll: aSystem sipProxyPort  asString;
			nextPutAll: ';lr>'
	]