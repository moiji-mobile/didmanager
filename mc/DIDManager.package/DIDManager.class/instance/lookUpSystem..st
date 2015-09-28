as yet unclassified
lookUpSystem: aDest
	[
		| route |
		route := database selectOne: SMPPMongoRoute where: [:itm | itm msisdn = aDest].
		^route isNil
			ifTrue: [
				logger logNotice: 'Failed to find route' with: { 'dest'->aDest }.
				statsdClient increment: 'did.route.notFound' rate: 1.
				nil]
			ifFalse: [
				logger logNotice: 'Selected route' with: { 'dest'->aDest. 'customerName'->route customer customerName }.
				statsdClient increment: 'did.route.selected' rate: 1.
				route customer].
	] on: Error do: [:e |
		logger logError: 'Failed Mongo query' with: { 'error'->e. 'dest'->aDest}.
		statsdClient increment: 'did.route.error' rate: 1.
		^nil
	].