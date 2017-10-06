comparing
= anotherMirror
	
	anotherMirror isOzMirror ifFalse: [ ^ false ].
	
	^ self pointsToSameObject: anotherMirror