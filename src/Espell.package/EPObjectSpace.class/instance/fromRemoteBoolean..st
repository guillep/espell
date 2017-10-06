transformations
fromRemoteBoolean: aBooleanMirror
	(aBooleanMirror pointsToSameObject: self trueObject)
		ifTrue: [ ^true ].
	(aBooleanMirror pointsToSameObject: self falseObject)
		ifTrue: [  ^false ].
	self error: 'non a boolean remote object'.