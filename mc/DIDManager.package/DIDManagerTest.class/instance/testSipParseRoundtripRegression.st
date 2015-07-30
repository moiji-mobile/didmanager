as yet unclassified
testSipParseRoundtripRegression
	| parser parsed |
	parser := SIPParser new.
	parsed := parser parse: self class exampleInvite asString.

	self shouldnt: [parsed asDatagram ] raise: Exception.
	self assert: parsed asDatagram equals: self class exampleInvite asString.