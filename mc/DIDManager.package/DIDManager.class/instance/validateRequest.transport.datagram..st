as yet unclassified
validateRequest: aRequest transport: aTransport datagram: aDatagram
	| maxForward via |

	"1. Reasonable Syntax check is already passed"
	via := aRequest parameter: 'Via' ifAbsent: [
		logger logNotice: 'SIP request lacks Via' with: {}.
		self returnError: 400 with: 'Missing Via' to: aDatagram transport: aTransport.
		^false].
	(via branch beginsWith: 'z9hG4bK') ifFalse: [
		logger logNotice: 'SIP request has wrong banch' with: {}.
		self returnError: 400 with: 'Wrong branch in Via' to: aDatagram transport: aTransport.
		^false].
	"2. URI scheme.. we don't care"
	"3. Max Forwards"
	maxForward := (aRequest parameter: 'Max-Forwards' ifAbsent: ['70']) asInteger.
	maxForward = 0 ifTrue: [
		logger logNotice: 'Max-Forwards too high' with: { 'Max-Forwards' -> maxForward }.
		self returnError: 483 with: 'Too many hops' to: aDatagram transport: aTransport.
		^false].
	"4. (Optional) Loop Detection.. we don't care"
	"5. Proxy-Require.. TODO.. check and error"
	self flag: #todo. "We need to check if there are any.."
	"6. Proxy-Authorization.. we don't care"
	^true