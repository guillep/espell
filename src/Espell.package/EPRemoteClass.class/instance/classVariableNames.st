class variables
classVariableNames
	
	mirror classPool isNilObject ifTrue: [ ^ #() ].
	^ self classPool keys asArray