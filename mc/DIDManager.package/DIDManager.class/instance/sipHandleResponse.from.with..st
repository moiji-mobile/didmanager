as yet unclassified
sipHandleResponse: aResponse from: aTransport with: aDatagram
	| via  storedDestRoute newRoute datagram |
	"We don't need to do most of this for stateless proxies. Let's list the
	steps here anyway."

	"1. Find the appropriate response context"
	"2. Update timer C for provisional response"
	"3. Remove the topmost Via"
	via := aResponse parameter: 'Via' ifAbsent: [
			statsdClient increment: 'did.resp.missingVia' rate: 1.
		logger logError: 'Missing Via on response' with: { }.
		^self].
	self flag: #todo. "TODO: we need to check the branch here"
	aResponse removeParameter: 'Via'.
	via := aResponse parameter: 'Via' ifAbsent: [
		statsdClient increment: 'did.resp.wrongVia' rate: 1.
		logger logNotice: 'Message is terminated for us?' with: { }.
		^self].

	"4. Add the response to the response context"
	"5. Check to see if this response should be forwarded immediately"
	"6. When necessary, choose the best final response from the response context"
	"7. Aggregate authorization header field values if necessary"
	"8. Optionally rewrite Record-Route header field values"
	storedDestRoute := aResponse parameter: 'Record-Route' ifAbsent: [
		statsdClient increment: 'did.resp.wrongRecordRoute' rate: 1.
		logger logNotice: 'Reply to something we have not routed?' with: { }.
		nil
	].
	"Remove the two routes if the equipment manages to follow the spec"
	storedDestRoute ifNotNil: [
		aResponse removeParameter: 'Record-Route'.
		aResponse removeParameter: 'Record-Route'.

		self flag: #todo. "Check if this could have been our route?"
		newRoute := aTransport == localUdpTransport
			ifTrue: [self remoteRecordRoute]
			ifFalse: [self localRecordRoute].
		aResponse prependParameter: 'Record-Route' with: newRoute after: 'Via'.
		aResponse prependParameter: 'Record-Route' with: storedDestRoute after: 'Via'].

	"9. Forward the response"
	datagram := OsmoUDPDatagram new
		data: aResponse asDatagram;
		address: (NetNameResolver addressForName: via address);
		port: (via port isNil ifTrue: [5060] ifFalse: [via port]);
		yourself.
	self sendOnOtherTransport: aTransport datagram: datagram.
	"10.0 Generate any necessary CANCEL requests" 