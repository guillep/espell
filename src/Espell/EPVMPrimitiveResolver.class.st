"
I represent the entry point for primitive execution. I keep record of all primitives and their specific transformations. Then, people can just ask me to execute a primitive by number (or name and module).
"
Class {
	#name : 'EPVMPrimitiveResolver',
	#superclass : 'Object',
	#instVars : [
		'numberedPrimitives',
		'modules',
		'backend'
	],
	#category : 'Espell-LowLevel-Primitives',
	#package : 'Espell',
	#tag : 'LowLevel-Primitives'
}

{ #category : 'well known primitives' }
EPVMPrimitiveResolver >> atIndex: anIndexMirror ofString: aStringMirror put: aCharacterMirror [
	
	^ self
		invokePrimitiveNumber: 64
		on: aStringMirror target
		arguments: { anIndexMirror target . aCharacterMirror asLocalLiteral }
]

{ #category : 'accessing' }
EPVMPrimitiveResolver >> backend [

	^ backend
]

{ #category : 'initialize-release' }
EPVMPrimitiveResolver >> backend: aBackend [
	backend := aBackend
]

{ #category : 'execution' }
EPVMPrimitiveResolver >> basicExecutePrimitive: aPrimitiveNumber onObject: anObject [
	^ self basicExecutePrimitive: aPrimitiveNumber onObject: anObject withArguments: { }
]

{ #category : 'execution' }
EPVMPrimitiveResolver >> basicExecutePrimitive: aPrimitiveNumber onObject: anObject withArguments: anArrayOfArguments [
	| result |
	result := backend mirrorOn: ((ProtoObject >> #tryPrimitive:withArgs:)
		executeOn: anObject withArguments: { aPrimitiveNumber . anArrayOfArguments }).
	
	(self hasPrimitiveFailed: result) ifTrue: [ self primitiveFailed ].
	^result
]

{ #category : 'well known primitives' }
EPVMPrimitiveResolver >> basicNewOn: aClassHandle [
	
	^ self basicNewOn: aClassHandle withSize: 0
]

{ #category : 'well known primitives' }
EPVMPrimitiveResolver >> basicNewOn: aClassHandle withSize: aSizeObjectMirror [

	^ self
		invokePrimitiveNumber: 71
		on: aClassHandle
		arguments: { aSizeObjectMirror }
]

{ #category : 'well known primitives' }
EPVMPrimitiveResolver >> changeClassOf: anObjectMirror to: aClassMirror [

	self
		basicExecutePrimitive: 160
		onObject: aClassMirror target
		withArguments: { anObjectMirror target }.
]

{ #category : 'well known primitives' }
EPVMPrimitiveResolver >> classOf: anObjectHandle [
	
	^ self
		invokePrimitiveNumber: 111
		on: anObjectHandle
		arguments: {  }
]

{ #category : 'testing' }
EPVMPrimitiveResolver >> hasPrimitiveFailed: result [
	"A primitive that fails doesn't always return ContextPart primitiveFailToken but returns ContextPart primitiveFailTokenFor: errorCode.
	A possible errorCode is nil, which corresponds to ContextPart primitiveFailToken.
	Here we loop over the errorCodes to know if the primitive has failed."

	| errorCodes |
	Context primitiveFailToken class == result primitiveClass
		ifFalse: [ ^ false ].
	result target size < 2
		ifTrue: [ ^ false ].
	errorCodes := SmalltalkImage current specialObjectsArray at: 52.
	^ errorCodes
		anySatisfy: [ :errorCode | 
			| token |
			token := Context primitiveFailTokenFor: errorCode.
			token first == result target first and: [ token second == result target second ] ]
]

{ #category : 'initialize-release' }
EPVMPrimitiveResolver >> initialize [
	super initialize.
	numberedPrimitives := Dictionary new.
	modules := Dictionary new.
	
	"SmallInteger primitives"
	3 to: 12 do: [ :primitiveNumber |
		(EPNumberedPrimitive new number: primitiveNumber) 
			transformResultToRemoteLiteral 
			installOn: self.
	].

	"Float primitives"
	38 to: 39 do: [ :primitiveNumber |
		(EPNumberedPrimitive new number: primitiveNumber) 
			transformArgumentsToRemoteLiteral
			transformResultToRemoteLiteral 
			installOn: self.
	].
	41 to: 50 do: [ :primitiveNumber |
		(EPNumberedPrimitive new number: primitiveNumber) 
			transformArgumentsToRemoteLiteral
			transformResultToRemoteLiteral 
			installOn: self.
	].

	"byteString/byteSymbol at:"
	(EPNumberedPrimitive new number: 63) 
		transformResultToRemoteLiteral 
		installOn: self.
		
	"byteString/byteSymbol at:put:"
	(EPNumberedPrimitive new number: 64) 
		transformArgumentsToRemoteLiteral
		installOn: self.
	
	"WriteStream nextPut:"
	((EPNumberedPrimitive new number: 66)
		transformArgumentsToRemoteLiteral
		transformResultToRemoteLiteral)
		installOn: self.
		
	"basicNew"
	(EPNewObjectInitializationPrimitiveDecorator
		decorate: (EPNumberedPrimitive new number: 70))
		installOn: self.
	(EPNewObjectInitializationPrimitiveDecorator
		decorate: (EPNumberedPrimitive new number: 71))
		installOn: self.
	
	(EPSemaphoreAdapterPrimitiveDecorator
		decorate: (EPNumberedPrimitive new number: 85))
		installOn: self.

	"=="
	(EPNumberedPrimitive new number: 110)
			transformResultToRemoteLiteral
			installOn: self.
	
	"get class"
	(EPNumberedPrimitive new number: 111)
			transformResultToRemoteClass
			installOn: self.
			
	"pointsTo:"
	(EPNumberedPrimitive new number: 132)
		transformResultToRemoteLiteral
		installOn: self.
	
	"primUTCMicrosecondsClock"
	(EPNumberedPrimitive new number: 240)
			transformResultToRemoteLiteral
			installOn: self.
	
	"isNil"
	257 to: 258 do: [ :primitiveNumber |
		(EPNumberedPrimitive new number: primitiveNumber)
			transformResultToRemoteLiteral
			installOn: self.
	].

	"Byte objects hash"
	((EPNamedPrimitiveModule new
		name: 'MiscPrimitivePlugin')
		addPrimitive: (EPNamedPrimitive new
			name:'primitiveStringHash')
			transformResultToRemoteLiteral)
			installOn: self.

	"*"
	((EPNamedPrimitiveModule new
		name: 'LargeIntegers')
		addPrimitive: (EPNamedPrimitive new
			name:'primDigitMultiplyNegative')
			transformResultToRemoteLiteral)
			installOn: self.
]

{ #category : 'execution' }
EPVMPrimitiveResolver >> invokePrimitiveMethod: aCompiledMethod on: receiver arguments: arguments [
	^ aCompiledMethod isNamedPrimitive
		ifTrue: [ ((self namedPrimitiveForMethod: aCompiledMethod)
							executionWithReceiver: receiver
							andArguments: arguments) execute ]
		ifFalse: [ ((self primitiveForNumber: aCompiledMethod primitive)
							executionWithReceiver: receiver
							andArguments: arguments) execute ]
]

{ #category : 'execution' }
EPVMPrimitiveResolver >> invokePrimitiveNumber: aNumber on: receiver arguments: arguments [

	^ ((self primitiveForNumber: aNumber)
				executionWithReceiver: receiver
				andArguments: arguments)
					execute

]

{ #category : 'accessing' }
EPVMPrimitiveResolver >> modules [

	^ modules
]

{ #category : 'primitive-configuration' }
EPVMPrimitiveResolver >> namedPrimitiveForMethod: aMethod [

	| primitivePragma module |
	primitivePragma := aMethod pragmas detect: #isPrimitive.
	module := self modules
		at: primitivePragma arguments second value
		ifAbsent: [ EPNamedPrimitiveModule new name: primitivePragma arguments second; yourself. ].
	^(module primitiveNamed: primitivePragma arguments first value)
		installOn: self;
		yourself
]

{ #category : 'primitive-configuration' }
EPVMPrimitiveResolver >> numberedPrimitives [
	^numberedPrimitives
]

{ #category : 'accessing' }
EPVMPrimitiveResolver >> objectSpace [

	^ backend
]

{ #category : 'primitive-configuration' }
EPVMPrimitiveResolver >> primitiveForModuleName: aPrimitiveModuleName put: aPrimitiveModule [
	^ modules at: aPrimitiveModuleName put: aPrimitiveModule
]

{ #category : 'primitive-configuration' }
EPVMPrimitiveResolver >> primitiveForNumber: aPrimitiveNumber [
	^ self numberedPrimitives
		at: aPrimitiveNumber
		ifAbsent: [ ^EPNumberedPrimitive new number: aPrimitiveNumber; installOn: self; yourself. ]
]

{ #category : 'primitive-configuration' }
EPVMPrimitiveResolver >> primitiveForNumber: aPrimitiveNumber put: aPrimitive [
	^ self numberedPrimitives at: aPrimitiveNumber put: aPrimitive
]
