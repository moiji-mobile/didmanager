as yet unclassified
doWork: aWork
	| transport msg |
	transport := aWork key.
	msg := aWork value.

	didManager transportData: transport data: msg.