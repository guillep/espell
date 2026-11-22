Class {
	#name : 'EPPrimitivesTest',
	#superclass : 'EPBaseTest',
	#instVars : [
		'primitiveResolver'
	],
	#category : 'Espell-Tests',
	#package : 'Espell',
	#tag : 'Tests'
}

{ #category : 'accessing' }
EPPrimitivesTest class >> resources [

	^{ EPTestResource }
]

{ #category : 'running' }
EPPrimitivesTest >> setUp [

	super setUp.
	objectSpace := EPTestResource current objectSpace.
	primitiveResolver := EPVMPrimitiveResolver new backend: objectSpace backend; yourself
]

{ #category : 'tests' }
EPPrimitivesTest >> testExecutePrimitive [

	objectSpace backend nilObject markExperimentalBit: true
]

{ #category : 'tests' }
EPPrimitivesTest >> testPrimitiveClassOfReturnsClassForImmediateObjects [

	"(SmallInteger >> #>) primitive"
	
	| primitive result |
	primitive := ((EPNumberedPrimitive new number: 111)
		resolver: primitiveResolver)
			transformResultToRemoteClass
			resolver: primitiveResolver;
			yourself.
	result := (primitive executionWithReceiver: (objectSpace backend mirrorOn:1) andArguments: #()) execute.

	self assert: result equals: objectSpace backend smallIntegerClass
]

{ #category : 'tests' }
EPPrimitivesTest >> testPrimitiveResolverBasicNewObject [

	| result |
	result := primitiveResolver
		invokePrimitiveNumber: 71
		on: (objectSpace backend arrayClass)
		arguments: { objectSpace backend mirrorOn: 2 }.
	
	self assert: result basicClass equals: objectSpace backend arrayClass.
	self assert: (result at: 1) isNilObject.
	self assert: (result at: 2) isNilObject
]

{ #category : 'tests' }
EPPrimitivesTest >> testPrimitiveResolverPrimitiveGetClass [

	| result |
	result := primitiveResolver
		invokePrimitiveNumber: 111
		on: (objectSpace backend mirrorOn:1)
		arguments: #().
	self assert: result equals: objectSpace backend smallIntegerClass
]

{ #category : 'as yet unclassified' }
EPPrimitivesTest >> testPrimitiveResolverStringAt [

	| result |
	result := primitiveResolver
		invokePrimitiveNumber: 63
		on: (objectSpace backend arrayClass instanceVariableAtIndex: 8)
		arguments: { objectSpace backend mirrorOn: 1 }.
	
	self assert: result basicClass equals: objectSpace backend characterClass.
	self assert: result asLocalLiteral equals: $A.
]

{ #category : 'as yet unclassified' }
EPPrimitivesTest >> testPrimitiveResolverStringAtPut [

	| string |
	string := 'a' asLiteralInObjectSpace: objectSpace backend.
	primitiveResolver
		invokePrimitiveNumber: 64
		on: string
		arguments: { objectSpace backend mirrorOn: 1 . $A asLiteralInObjectSpace: objectSpace backend }.
	
	self assert: string asLocalLiteral equals: 'A'.
]

{ #category : 'tests' }
EPPrimitivesTest >> testPrimitiveWithFalseBooleanReturn [

	"(SmallInteger >> #>) primitive"
	
	| primitive result |
	primitive := ((EPNumberedPrimitive new number: 4)
		resolver: primitiveResolver)
			transformResultToRemoteLiteral
			resolver: primitiveResolver;
			yourself.
	result := (primitive
		executionWithReceiver: (objectSpace backend mirrorOn:1)
		andArguments: {(objectSpace backend mirrorOn:2)}) execute.
		
	self assert: result equals: objectSpace backend falseObject.
]

{ #category : 'tests' }
EPPrimitivesTest >> testPrimitiveWithTrueBooleanReturn [

	"(SmallInteger >> #<) primitive"
	
	| primitive result |
	primitive := ((EPNumberedPrimitive new number: 3)
		resolver: primitiveResolver)
			transformResultToRemoteLiteral
			resolver: primitiveResolver;
			yourself.
	result := (primitive
		executionWithReceiver: (objectSpace backend mirrorOn:1)
		andArguments: {(objectSpace backend mirrorOn:2)}) execute.
		
	self assert: result equals: objectSpace backend trueObject.
]
