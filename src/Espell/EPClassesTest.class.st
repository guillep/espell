Class {
	#name : 'EPClassesTest',
	#superclass : 'EPBaseTest',
	#category : 'Espell-Tests',
	#package : 'Espell',
	#tag : 'Tests'
}

{ #category : 'tests' }
EPClassesTest >> testClassNameIndex [

	"This is a Pharo 3.0"
	self assert: objectSpace backend classNameIndex equals: 8
]

{ #category : 'tests' }
EPClassesTest >> testGetGlobalObjectsReturnsExpectedSize [

	self assert: objectSpace globalObjects size equals: 5801
]

{ #category : 'tests' }
EPClassesTest >> testGetObjectClass [

	| object |
	object := objectSpace globalNamed: #Object.
	self assert: object superclass className equals: #ProtoObject.
]
