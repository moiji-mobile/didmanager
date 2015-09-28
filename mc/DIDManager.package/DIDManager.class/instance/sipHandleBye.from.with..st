as yet unclassified
sipHandleBye: aRequest from: aTransport with: aDatagram
	statsdClient increment: 'did.sip.bye' rate: 1.
	self sipHandleRoutedRequest: aRequest from: aTransport with: aDatagram.