Class {
	#name : #EPClassesTest,
	#superclass : #EPBaseTest,
	#category : #'Espell-Tests'
}

{ #category : #tests }
EPClassesTest >> testBasicNew [

	| association |
	association := (kernel classNamed: #Association) basicNew.
	self assert: (association basicClass pointsToSameObject: (kernel classNamed: #Association)).
	self assert: association fixedSize equals: 2.
	self assert: (association instanceVariableAtIndex: 1) isNilObject
]

{ #category : #tests }
EPClassesTest >> testBasicNewWithSize [

	| array |
	array := (kernel classNamed: #Array) basicNew: 3.
	self assert: array size equals: 3.
	self assert: (array at: 3) isNilObject
]

{ #category : #tests }
EPClassesTest >> testClassName [

	self assert: (kernel classNamed: #Object) className equals: #Object
]

{ #category : #tests }
EPClassesTest >> testClassOfAMetaclassIsMetaclass [

	self assert: (kernel classNamed: #Object) basicClass basicClass className equals: #Metaclass
]

{ #category : #tests }
EPClassesTest >> testInstanceFixedSize [

	self assert: (kernel classNamed: #Association) instanceFixedSize equals: 2.
	self assert: (kernel classNamed: #Array) instanceFixedSize equals: 0
]

{ #category : #tests }
EPClassesTest >> testIsBitsClass [

	self assert: (kernel classNamed: #ByteString) isBitsClass.
	self deny: (kernel classNamed: #Array) isBitsClass
]

{ #category : #tests }
EPClassesTest >> testSuperclass [

	self assert: (kernel classNamed: #Object) superclass className equals: #ProtoObject
]
