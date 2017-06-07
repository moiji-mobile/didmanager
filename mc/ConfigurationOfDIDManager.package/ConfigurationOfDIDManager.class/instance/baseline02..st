baselines
baseline02: spec
	<version: '0.2-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://source.selfish.org/o/private'.
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
			project: 'SMPPRouter' with: [
				spec
					className: #ConfigurationOfSMPPRouter;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/osmocom/SMPPRouter/main/' ];
			project: 'ZincHTTPComponents' with: [
				spec
					className: #ConfigurationOfZincHTTPComponents;
					versionString: #'stable';
					loads: #('REST' );
					repository: 'http://mc.stfx.eu/ZincHTTPComponents/' ];
			project: 'StatsDClient' with: [
				spec
					className: #ConfigurationOfStatsDClient;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/hfreyther2/StatsD/main/' ].
		spec package: #DIDManager with: [
				spec requires: #('OsmoLogging' 'OsmoSIP' 'OsmoMGCP' 'SMPPRouter' 'StatsDClient' ). ]. ].
