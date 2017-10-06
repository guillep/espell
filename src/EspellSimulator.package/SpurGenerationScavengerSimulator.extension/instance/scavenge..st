*EspellSimulator
scavenge: tenuringCriterion
	manager bootstrapping ifFalse:
		[coInterpreter transcript nextPutAll: 'scavenging('; print: manager statScavenges; nextPutAll: ')...'; flush].
	"self halt."
	^super scavenge: tenuringCriterion
	
