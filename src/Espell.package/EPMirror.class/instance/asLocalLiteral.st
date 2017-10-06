converting
asLocalLiteral
	(self basicClass pointsToSameObject: (self backend byteStringClass))
		ifTrue: [ ^self asLocalString ].
	(self basicClass pointsToSameObject: (self backend byteSymbolClass))
		ifTrue: [ ^self asLocalString asSymbol ].
	(self pointsToSameObject: self backend trueObject)
		ifTrue: [ ^true ].
	(self pointsToSameObject: self backend falseObject)
		ifTrue: [ ^false ].
	(self pointsToSameObject: self backend nilObject)
		ifTrue: [ ^nil ].
	(self basicClass pointsToSameObject: self backend arrayClass)
		ifTrue: [ ^(1 to: self size) collect: [ :each | (self at: each) asLocalLiteral ] ].
	(self basicClass pointsToSameObject: self backend smallIntegerClass)
		ifTrue: [ ^self target asSmallInteger ].
	(self basicClass pointsToSameObject: self backend associationClass)
		ifTrue: [ ^(self instanceVariableAtIndex: 1) asLocalLiteral -> nil ].
	(self basicClass pointsToSameObject: self backend characterClass)
		ifTrue: [ ^self backend fromRemoteCharacter: self ].
	(self basicClass pointsToSameObject: self backend floatClass)
		ifTrue: [ ^self backend fromRemoteFloat: self ].
	(self basicClass pointsToSameObject: self backend byteArrayClass)
		ifTrue: [ ^self backend fromRemoteByteArray: self ].
	(self basicClass pointsToSameObject: self backend largePositiveIntegerClass)
		ifTrue: [ ^self backend fromRemoteLargePositiveInteger: self ].
	(self basicClass pointsToSameObject: self backend largeNegativeIntegerClass)
		ifTrue: [ ^self backend fromRemoteLargeNegativeInteger: self ].
	^'not a translateable literal'