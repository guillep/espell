Class {
	#name : 'EPSpecialObjectsTest',
	#superclass : 'EPBaseTest',
	#category : 'Espell-Tests',
	#package : 'Espell',
	#tag : 'Tests'
}

{ #category : 'accessing' }
EPSpecialObjectsTest class >> resources [

	^{ EPTestResource }
]

{ #category : 'running' }
EPSpecialObjectsTest >> setUp [

	super setUp.
	objectSpace := EPTestResource current objectSpace
]

{ #category : 'tests' }
EPSpecialObjectsTest >> testArrayClassCompactIndexIsThree [

	self assert: objectSpace backend arrayClass asClassMirror compactClassIndex equals: 3
]

{ #category : 'tests' }
EPSpecialObjectsTest >> testArrayClassLooksLikeAClass [

	self assert: (objectSpace backend looksLikeClass: objectSpace backend arrayClass)
]

{ #category : 'tests' }
EPSpecialObjectsTest >> testCompactClassAtArrayIndexIsArrayClass [

	self assert: ((objectSpace backend compactClassAt: Array indexIfCompact ifNone: [ nil ])
		pointsToSameObject: objectSpace backend arrayClass)
]

{ #category : 'tests' }
EPSpecialObjectsTest >> testCompactClassesNotEmpty [

	self assert: objectSpace backend compactClasses notEmpty
]

{ #category : 'tests' }
EPSpecialObjectsTest >> testFalseObjectIsFalse [

	self deny: objectSpace backend falseObject asBoolean.
]

{ #category : 'tests' }
EPSpecialObjectsTest >> testNilObjectIsNil [

	self assert: objectSpace backend nilObject isNilObject.
]

{ #category : 'tests' }
EPSpecialObjectsTest >> testSmallIntegerIsSmallInteger [

	self assert: (objectSpace backend mirrorOn: 2) isSmallInteger.
]

{ #category : 'tests' }
EPSpecialObjectsTest >> testSpecialObjectsArrayIsArray [

	self
		assert: objectSpace backend specialObjectsArray basicClass
		equals: objectSpace backend arrayClass
]

{ #category : 'tests' }
EPSpecialObjectsTest >> testSystemDictionaryIsSystemDictionary [

	self assert: objectSpace backend systemDictionary basicClass className equals: 'SystemDictionary'
]

{ #category : 'tests' }
EPSpecialObjectsTest >> testSystemDictionaryNotEmpty [

	| tally |
	tally := objectSpace backend systemDictionary instanceVariableAtIndex: 1.
	self assert: tally isSmallInteger.
	self assert: tally target > 0
]

{ #category : 'tests' }
EPSpecialObjectsTest >> testTrueObjectIsTrue [

	self assert: objectSpace backend trueObject asBoolean.
]
