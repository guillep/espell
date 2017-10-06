instance variables
instanceVariableNames
	
	| remoteInstVars |
	remoteInstVars := mirror instanceVariableAtIndex: 5.
	remoteInstVars isNilObject ifTrue: [ ^ #() ].
	^ remoteInstVars asLocalLiteral