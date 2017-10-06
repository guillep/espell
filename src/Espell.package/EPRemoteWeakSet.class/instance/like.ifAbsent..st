accessing
like: anObject ifAbsent: aBlock
	"Answer an object in the receiver that is equal to anObject,
	or evaluate the block if not found. Relies heavily on hash properties"

	| element array flag |
	array := mirror instanceVariableAtIndex: 2.
	flag := mirror instanceVariableAtIndex: 3.
	((element  := array at: (self scanFor: anObject)) = flag or: [ element isNilObject ])
		ifTrue: [ ^ aBlock value ]
		ifFalse: [ ^ element ]