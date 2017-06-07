versions
version1: spec
	<version: '1' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1'.
		spec author: 'HolgerHansPeterFreyther'.
		spec timestamp: '9/28/2015 13:27'.
		spec 
			project: 'OsmoSIP' with: '0.1-baseline';
			project: 'OsmoMGCP' with: '0.1-baseline';
			project: 'OsmoLogging' with: '0.1-baseline';
			project: 'VoyageMongo' with: '1.3.1';
			project: 'SMPPRouter' with: '0.2-baseline';
			project: 'ZincHTTPComponents' with: '2.6.6'.
		spec package: #DIDManager with: 'DIDManager-HolgerHansPeterFreyther.12'. ].
