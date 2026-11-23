Class {
	#name : #EPClassesTest,
	#superclass : #EPBaseTest,
	#category : #'Espell-Tests'
}

{ #category : #tests }
EPClassesTest >> testBasicNew [

	| association |
	association := (kernel classMirrorNamed: #Association) basicNew.
	self assert: (association basicClass pointsToSameObject: (kernel classMirrorNamed: #Association)).
	self assert: association fixedSize equals: 2.
	self assert: (association instanceVariableAtIndex: 1) isNilObject
]

{ #category : #tests }
EPClassesTest >> testBasicNewWithSize [

	| array |
	array := (kernel classMirrorNamed: #Array) basicNew: 3.
	self assert: array size equals: 3.
	self assert: (array at: 3) isNilObject
]

{ #category : #tests }
EPClassesTest >> testClassName [

	self assert: (kernel classMirrorNamed: #Object) className equals: #Object
]

{ #category : #tests }
EPClassesTest >> testClassOfAMetaclassIsMetaclass [

	self assert: (kernel classMirrorNamed: #Object) basicClass basicClass className equals: #Metaclass
]

{ #category : #tests }
EPClassesTest >> testInstanceFixedSize [

	self assert: (kernel classMirrorNamed: #Association) instanceFixedSize equals: 2.
	self assert: (kernel classMirrorNamed: #Array) instanceFixedSize equals: 0
]

{ #category : #tests }
EPClassesTest >> testIsBitsClass [

	self assert: (kernel classMirrorNamed: #ByteString) isBitsClass.
	self deny: (kernel classMirrorNamed: #Array) isBitsClass
]

{ #category : #tests }
EPClassesTest >> testSuperclass [

	self assert: (kernel classMirrorNamed: #Object) superclass className equals: #ProtoObject
]
