baselines
baseline01: spec
	<version: '0.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/hfreyther2/Junk/main/'.
		spec 
			project: 'OsmoSIP' with: [
				spec
					className: #ConfigurationOfOsmoSIP;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/osmocom/SIP/main/' ];
			project: 'OsmoMGCP' with: [
				spec
					className: #ConfigurationOfOsmoMGCP;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/osmocom/MGCP/main/' ];
			project: 'OsmoLogging' with: [
				spec
					className: #ConfigurationOfOsmoLogging;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/osmocom/Logging/main/' ];
			project: 'VoyageMongo' with: [
				spec
					className: #ConfigurationOfVoyageMongo;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/estebanlm/Voyage/main/' ].
		spec package: #DIDManager with: [
				spec requires: #('OsmoLogging' 'OsmoSIP' 'OsmoMGCP' 'VoyageMongo' ). ]. ].
