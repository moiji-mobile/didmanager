as yet unclassified
initWith: aSipMessage from: aDatagram 
	^self new
		updateLastUsed;
		sourceAddress: aDatagram address;
		sourcePort: aDatagram port;
		callId: (aSipMessage parameter: 'Call-ID' ifAbsent: [nil]);
		yourself