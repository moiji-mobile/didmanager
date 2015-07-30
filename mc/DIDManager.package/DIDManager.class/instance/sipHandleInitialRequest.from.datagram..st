forward
sipHandleInitialRequest: anInvite from: aTransport datagram: aDatagram
	|  requestUser system |
	requestUser := anInvite dest user.
	system := self lookUpSystem: requestUser.
	system ifNil: [
		logger logError: 'Unknown destination' with: { 'requestUser' -> requestUser }.
		^self].
	self statelesHandleRequest: anInvite from: aTransport datagram: aDatagram to: system.
