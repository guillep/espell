accessing
like: anObject ifAbsent: aBlock

	"Answer an object in the receiver that is equal to anObject,
	or evaluate the block if not found. Relies heavily on hash properties"

	| element array |
	array := mirror instanceVariableAtIndex: 2.
	(element := array at: (self scanFor: anObject)) isNilObject
		ifTrue: [ ^ aBlock value ]
		ifFalse: [
			"a WeakSet contains ephemeric objects containing the real element in the 1st IV" 
			^ element instanceVariableAtIndex: 1 ]