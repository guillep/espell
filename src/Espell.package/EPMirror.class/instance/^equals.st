comparing
= anotherMirror
	
	(anotherMirror isKindOf: self class) ifFalse: [ ^ false ].
	
	anotherMirror isOzMirror ifFalse: [ ^ false ].
	
	^ self pointsToSameObject: anotherMirror