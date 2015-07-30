forward
handleDataInternal: aDatagram transport: aTransport
	| data parsed |
	data := aDatagram data copyFrom: 1 to: aDatagram size. 
	parsed := sipParser parse: data asString.
	parsed isPetitFailure ifTrue: [
		logger logError: 'Failed to parse: ' with: { 'msg' -> data hex. 'srcIp' -> aDatagram address. 'srcPort' -> aDatagram port}.
		^self].

	parsed didSIPDispatch: self from: aTransport with: aDatagram.