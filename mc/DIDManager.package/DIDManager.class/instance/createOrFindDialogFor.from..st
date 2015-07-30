dialogue-tracking
createOrFindDialogFor: anInvite from: aDatagram 
	sem critical: [
		dialogues do: [:each |
			(each isCompatible: anInvite from: aDatagram) ifTrue: [
				^each]].
		^dialogues add:
			(DIDDialogue initWith: anInvite from: aDatagram)
	]