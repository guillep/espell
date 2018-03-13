instance variables
instanceVariableNames
	| remoteInstVars index |

	index := self mirror backend instanceVariableMapping classInstanceVariableNamesIndex.
	index ifNil: [ ^ #() ].
	remoteInstVars := mirror instanceVariableAtIndex: index.
	remoteInstVars isNilObject
		ifTrue: [ ^ #() ].
	^ remoteInstVars asLocalLiteral