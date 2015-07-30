creating
initialize
	sipParser := SIPParser new.
	sem := Semaphore forMutualExclusion.
	dialogues := OrderedCollection new.
	branchSeed := (OsmoSecureRandom rand: 4) hex.