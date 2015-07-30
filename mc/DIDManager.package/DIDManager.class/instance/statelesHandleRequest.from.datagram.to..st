as yet unclassified
statelesHandleRequest: aRequest from: aTransport datagram: aDatagram to: aSystem 
	| maxForward datagram |
	(self validateRequest: aRequest transport: aTransport datagram: aDatagram) ifFalse: [
		^self].

	"16.6 Request Forwarding:"
	"1. Make a copy of the received request -> ignore"
	"2. Update the Request-URI -> skip"
	"3. Update the Max-Forwards header field"
	maxForward := (aRequest parameter: 'Max-Forwards' ifAbsent: ['70']) asInteger.
	aRequest updateParameter: 'Max-Forwards' with: (maxForward - 1) asString.
	
	"4. Optionally add a Record-route header"
	"The most recent route should be added to the top. So the 'fake' one should be
	added second but both Zoiper/Linphone contact the last rule first. I am confused

         If this proxy wishes to remain on the path of future requests                   
         in a dialog created by this request (assuming the request
         creates a dialog), it MUST insert a Record-Route header field                   
         value into the copy before any existing Record-Route header
         field values, even if a Route header field is already present. 

	."
	aRequest prependParameter: 'Record-Route' with: self remoteRecordRoute.
	aRequest prependParameter: 'Record-Route' with: (self buildRecordRoute: aSystem).

	"5. Optionally add additional header fields -> nothing"
	"6. Postprocess routing information"
	"7. Determine the next-hop address, port, and transport .. we already know it and will ignore route"
	"8. Add a Via header field value"
	aRequest prependParameter: 'Via' with: (self remoteViaFor: aRequest).
	
	"9. Add a Content-Length header field if necessary"
	"10. Forward the new request"

	datagram := OsmoUDPDatagram new
		data: aRequest asDatagram;
		address: (NetNameResolver addressForName: aSystem sipProxyIP);
		port: aSystem sipProxyPort;
		yourself.
	self sendOnOtherTransport: aTransport datagram: datagram.