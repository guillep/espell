Class {
	#name : #EPSpecialObjectsTest,
	#superclass : #EPBaseTest,
	#category : #'Espell-Tests'
}

{ #category : #tests }
EPSpecialObjectsTest >> testArrayClassIsInTheClassTable [

	| memory |
	memory := self backend objectMemory.
	self assert: (memory classAtIndex: 51) equals: self backend arrayClass target address.
	self assert: (memory classAtIndex: memory arrayClassIndexPun) equals: self backend arrayClass target address
]

{ #category : #tests }
EPSpecialObjectsTest >> testCharacterClassIsAtIndexTwoOfTheClassTable [

	self assert: (self backend objectMemory classAtIndex: 2) equals: self backend characterClass target address
]

{ #category : #tests }
EPSpecialObjectsTest >> testFalseObjectIsFalse [

	self deny: objectSpace backend falseObject asBoolean.
]

{ #category : #tests }
EPSpecialObjectsTest >> testImmediateObjectsHaveTheirSpecialClass [

	self assert: ((self mirrorOn: 2) basicClass pointsToSameObject: self backend smallIntegerClass).
	self assert: (($a asLiteralInObjectSpace: objectSpace) basicClass pointsToSameObject: self backend characterClass)
]

{ #category : #tests }
EPSpecialObjectsTest >> testNilObjectIsNil [

	self assert: objectSpace backend nilObject isNilObject.
]

{ #category : #tests }
EPSpecialObjectsTest >> testSmallIntegerClassIsAtIndexOneOfTheClassTable [

	self assert: (self backend objectMemory classAtIndex: 1) equals: self backend smallIntegerClass target address
]

{ #category : #tests }
EPSpecialObjectsTest >> testSmallIntegerIsSmallInteger [

	self assert: (self mirrorOn: 2) isSmallInteger
]

{ #category : #tests }
EPSpecialObjectsTest >> testSpecialObjectsArrayIsArray [

	self
		assert: objectSpace backend specialObjectsArray basicClass
		equals: objectSpace backend arrayClass
]

{ #category : #tests }
EPSpecialObjectsTest >> testSystemDictionaryIsSystemDictionary [

	self assert: objectSpace backend systemDictionary basicClass className equals: 'SystemDictionary'
]

{ #category : #tests }
EPSpecialObjectsTest >> testSystemDictionaryNotEmpty [

	| tally |
	tally := self backend systemDictionary instanceVariableAtIndex: 1.
	self assert: tally isSmallInteger.
	self assert: tally asSmallInteger > 0
]

{ #category : #tests }
EPSpecialObjectsTest >> testTrueObjectIsTrue [

	self assert: objectSpace backend trueObject asBoolean.
]
