forward
sipHandleCancel: anInvite from: aTransport with: aDatagram
	| route |
	self flag: #todo. "Check that it is either a Re-INVITE or originating from here"
	statsdClient increment: 'did.sip.cancel' rate: 1.
	route := anInvite parameter: 'Route' ifAbsent: [
		^self sipHandleInitialRequest: anInvite from: aTransport datagram: aDatagram].

	"Okay it has a route.. route it along this path"
	self sipHandleRoutedRequest: anInvite from: aTransport with: aDatagram.
