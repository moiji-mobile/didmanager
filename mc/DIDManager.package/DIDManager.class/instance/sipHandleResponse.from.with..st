as yet unclassified
sipHandleResponse: aResponse from: aTransport with: aDatagram
	| via  storedDestRoute newRoute datagram |
	"We don't need to do most of this for stateless proxies. Let's list the
	steps here anyway."

	"1. Find the appropriate response context"
	"2. Update timer C for provisional response"
	"3. Remove the topmost Via"
	via := aResponse parameter: 'Via' ifAbsent: [
		logger logError: 'Missing Via on response' with: { }.
		^self].
	self flag: #todo. "TODO: we need to check the branch here"
	aResponse removeParameter: 'Via'.
	via := aResponse parameter: 'Via' ifAbsent: [
		logger logNotice: 'Message is terminated for us?' with: { }.
		^self].

	"4. Add the response to the response context"
	"5. Check to see if this response should be forwarded immediately"
	"6. When necessary, choose the best final response from the response context"
	"7. Aggregate authorization header field values if necessary"
	"8. Optionally rewrite Record-Route header field values"
	storedDestRoute := aResponse parameter: 'Record-Route' ifAbsent: [
		logger logNotice: 'Reply to something we have not routed?' with: { }.
		^self
	].
	"Remove the two routes"
	aResponse removeParameter: 'Record-Route'.
	aResponse removeParameter: 'Record-Route'.
	self flag: #todo. "Check if this could have been our route?"
	newRoute := aTransport == localUdpTransport
		ifTrue: [self remoteRecordRoute]
		ifFalse: [self localRecordRoute].
	aResponse prependParameter: 'Record-Route' with: newRoute.
	aResponse prependParameter: 'Record-Route' with: storedDestRoute.
	"9. Forward the response"
	datagram := OsmoUDPDatagram new
		data: aResponse asDatagram;
		address: (NetNameResolver addressForName: via address);
		port: (via port isNil ifTrue: [5060] ifFalse: [via port]);
		yourself.
	self sendOnOtherTransport: aTransport datagram: datagram.
	"10.0 Generate any necessary CANCEL requests" 