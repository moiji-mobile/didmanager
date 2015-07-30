as yet unclassified
transportData: aTransport data: aData
	aData size < 5 ifTrue: [
		^self].
	"OsmoDispatcher dispatchBlock: [" self handleDataInternal: aData transport: aTransport"]"