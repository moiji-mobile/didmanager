as yet unclassified
lookUpSystem: aString 
	self flag: #todo. "Add the look-up"
	^SMPPMongoDIDCustomer new
		customerName: 'Test';
		sipProxyIP: '127.0.0.1';
		sipProxyPort: 5061;
		yourself