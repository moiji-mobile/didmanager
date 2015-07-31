as yet unclassified
sipHandleRoutedRequest: aRequest from: aTransport with: aDatagram 
	| route  system |
	"This is the route that got us here..."
	route := aRequest parameter: 'Route' ifAbsent: [
		logger logError: 'Request has no route' with: { 'data' -> aDatagram data hex }.
		self returnError: 400 with: 'Missing route' to: aDatagram transport: aTransport.
		^self
	].
	"This is the route we added to remember the target system"
	aRequest removeParameter: 'Route'.
	route := aRequest parameter: 'Route' ifAbsent: [
		logger logError: 'Request has no route' with: { 'data' -> aDatagram data hex }.
		self returnError: 400 with: 'Missing route' to: aDatagram transport: aTransport.
		^self
	].
	aRequest removeParameter: 'Route'.

	self flag: #todo. "Check if there is a lr, extend the SIPGrammar/Parser for route_rec
	and verify that the packet comes from the right transport"

	aTransport == localUdpTransport
		ifTrue: [
			system := SMPPMongoDIDCustomer new
				customerName: 'Ad-hoc-routing';
				sipProxyIP: route address host;
				sipProxyPort: (route address port ifNil: [5060] ifNotNil: [:port | port asInteger]);
				yourself]
		ifFalse: [
			system := SMPPMongoDIDCustomer new
				customerName: 'Ad-hoc-return';
				sipProxyIP: aRequest dest host;
				sipProxyPort: ((aRequest dest port ifNil: [5060] ifNotNil: [:port | port asInteger]));
				yourself].

	^self statelesHandleRequest: aRequest from: aTransport datagram: aDatagram to: system. 