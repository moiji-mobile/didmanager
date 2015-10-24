as yet unclassified
returnError: anInteger with: aString to: anOsmoUDPDatagram transport: anUndefinedObject 
	"Ignore the error and move on. In case of an error to an ACK we should just ignore
	it. Otherwise we create a loop of things. Until we have a good reason to get active,
	let's avoid it."
	logger logNotice: 'Returning an error is not done' with: {}.