as yet unclassified
transportData: aTransport data: aData
	aData size < 5 ifTrue: [
		statsdClient increment: 'did.shortSIP' rate: 1.
		statsdClient flush.
		^self].

	statsdClient increment: 'did.net.recv' rate: 1.
	self handleDataInternal: aData transport: aTransport.
	statsdClient flush.