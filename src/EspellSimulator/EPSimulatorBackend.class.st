Class {
	#name : #EPSimulatorBackend,
	#superclass : #EPBackend,
	#instVars : [
		'simulator',
		'extraRoots'
	],
	#category : #EspellSimulator
}

{ #category : #'instance-creation' }
EPSimulatorBackend class >> for32Bit [

	^ self withOptions: #(#ObjectMemory #Spur32BitMemoryManager)
]

{ #category : #'instance-creation' }
EPSimulatorBackend class >> for64Bit [

	^ self withOptions: #(#ObjectMemory #Spur64BitMemoryManager)
]

{ #category : #'instance-creation' }
EPSimulatorBackend class >> simulator: aSimulator [
	
	^ self new
		simulator: aSimulator;
		yourself
]

{ #category : #'instance-creation' }
EPSimulatorBackend class >> withOptions: options [

	| simulator |
	simulator := StackInterpreterSimulator newWithOptions: options.
	simulator desiredNumStackPages: 8.
	simulator instVarNamed: 'assertVEPAES' put: false.
	simulator initStackPages.
	^ self simulator: simulator
]

{ #category : #adding }
EPSimulatorBackend >> addExtraRoot: anObject [

	extraRoots add: anObject
]

{ #category : #'special objects' }
EPSimulatorBackend >> arrayClass: aMirror [ 
	
	super arrayClass: aMirror.
	self installClass: aMirror inClassTableIndex: 51.
	
	"Array is a special class that resides in the first page of the class table.
	Array is duplicated in the special class index 16, that can also be obtained by querying the memory manager as follows:
	
		self objectMemory arrayClassIndexPun.
		
	Usually, a class hash must be the same as the class index in the class table. But, since the class is in two different positions, one of them does not hold that invariant.
	To install the class in the table in both positions, we use an Unchecked version of the method that contains no assertions of that invariant."
	self objectMemory classAtIndex: self objectMemory arrayClassIndexPun putUnchecked: aMirror target address.
]

{ #category : #primitives }
EPSimulatorBackend >> basicIdentityHashOf: aMirror [
	
	^ self objectMemory hashBitsOf: aMirror target address
]

{ #category : #'as yet unclassified' }
EPSimulatorBackend >> basicIdentityHashOnClass: aHandle [

	^ [ self objectMemory ensureBehaviorHash: aHandle address]
		on: AssertionFailure do: [ :e | 
			"Retry because we may have forwarders"
			e resumeUnchecked: nil ]
]

{ #category : #'as yet unclassified' }
EPSimulatorBackend >> basicNewOn: theClass [
	
	| newOop newObject |
	newOop := self objectMemory instantiateClass: theClass target address.
	self assert: newOop notNil.
	
	newObject := self mirrorOnAddress: newOop.
	1 to: theClass instanceFixedSize do: [ :index |
		newObject instanceVariableAtIndex: index put: self nilObject.
	].
	theClass isBitsClass ifFalse: [
		1 to: newObject size do: [ :index |
			newObject at: index put: self nilObject.
		].
	].
	^ newObject
]

{ #category : #primitives }
EPSimulatorBackend >> basicNewOn: theClass withSize: anEPSimulatorSmallIntegerMirror [ 
	
	| newOop newObject |
	newOop := self objectMemory instantiateClass: theClass target address indexableSize: anEPSimulatorSmallIntegerMirror asLocalSmallInteger.
	self assert: newOop notNil.
	
	newObject := self mirrorOnAddress: newOop.
	1 to: theClass instanceFixedSize do: [ :index |
		newObject instanceVariableAtIndex: index put: self nilObject.
	].
	theClass isBitsClass ifFalse: [
		1 to: newObject size do: [ :index |
			newObject at: index put: self nilObject.
		].
	].
	^ newObject
]

{ #category : #primitives }
EPSimulatorBackend >> basicSizeOf: anEPMirror [ 
	
	^ self simulator uncheckedStSizeOf: anEPMirror target address
]

{ #category : #'as yet unclassified' }
EPSimulatorBackend >> become: anObject into: anotherObject [
	
	| origin destiny |
	origin := self arrayClass basicNew: 1.
	origin at: 1 put: anObject.
	
	destiny := self arrayClass basicNew: 1.
	destiny at: 1 put: anotherObject.
	
	[self objectMemory
		become: origin target address
		with: destiny target address
		twoWay: false
		copyHash: true] on: AssertionFailure do: [ :e | 
			"Resume, we may have forwarders"
			e pass "resumeUnchecked: nil" ].
	
	extraRoots do: [ :each |
		"we become also the root objects such as byteSymbol class"
		anObject target == each target ifTrue: [ 
			each target: anotherObject target ]
	].
]

{ #category : #'special objects' }
EPSimulatorBackend >> blockClass: aMirror [ 
	
	super blockClass: aMirror.
	self installClass: aMirror inClassTableIndex: 37
]

{ #category : #'special objects' }
EPSimulatorBackend >> byteArrayClass: aMirror [ 
	
	super byteArrayClass: aMirror.
	self installClass: aMirror inClassTableIndex: 50.
]

{ #category : #'special objects' }
EPSimulatorBackend >> byteStringClass: aMirror [ 
	
	super byteStringClass: aMirror.
	self objectMemory setHashBitsOf: aMirror target address to: 52.
	self objectMemory classAtIndex: 52 putUnchecked: aMirror target address.
	aMirror target: aMirror target asClassIndexHandle.
]

{ #category : #'special objects' }
EPSimulatorBackend >> characterClass: aClass [

	super characterClass: aClass.
	self objectMemory setHashBitsOf: aClass target address to: 2.
	self objectMemory classAtIndex: 2 putUnchecked: aClass target address.
	aClass target: aClass target asClassIndexHandle.
]

{ #category : #'class table' }
EPSimulatorBackend >> classAtIndex: anInteger [ 
	
	^ simulator objectMemory classAtIndex: anInteger
]

{ #category : #s }
EPSimulatorBackend >> classHandle: aClass setTo: anObject [
	
	self objectMemory changeClassOf: anObject address to: aClass address
]

{ #category : #primitives }
EPSimulatorBackend >> classOf: aMirror [
	
	^ self objectMemory fetchClassOf: aMirror target address
]

{ #category : #'as yet unclassified' }
EPSimulatorBackend >> compactClassIndexOf: aClassMirror [
	
	"All classes in Spur are compact, which also means that Spur has no compact classes"
	^ 0
]

{ #category : #'as yet unclassified' }
EPSimulatorBackend >> compiledMethod: anEPVMCompiledMethodMirror objectAt: anInteger [ 
	
	^ self object: anEPVMCompiledMethodMirror instVarAt: anInteger
]

{ #category : #'as yet unclassified' }
EPSimulatorBackend >> compiledMethod: anEPVMCompiledMethodMirror objectAt: anInteger put: anEPMirror [ 
	
	self object: anEPVMCompiledMethodMirror instVarAt: anInteger put: anEPMirror
]

{ #category : #'special objects' }
EPSimulatorBackend >> contextClass: aMirror [ 
	
	super contextClass: aMirror.
	self installClass: aMirror inClassTableIndex: 36.
]

{ #category : #'as yet unclassified' }
EPSimulatorBackend >> contextSizeOf: anEPContextMirror [ 
	
	^ self simulator uncheckedContextStSzeOf: anEPContextMirror target address
]

{ #category : #'as yet unclassified' }
EPSimulatorBackend >> createCompiledBlockWithSize: bytecodeSize andHeader: methodHeader [ 
	
	"self objectMemory instantiateCompiledMethodClass: self methodClass target address indexableSize: bytecodeSize"
	
	^ (self
		executePrimitiveNumber: 79
		on: self compiledBlockClass
		withArguments: { self smallIntegerMirrorOn: bytecodeSize . self smallIntegerMirrorOn: methodHeader })
			value asMethodMirror
]

{ #category : #'as yet unclassified' }
EPSimulatorBackend >> createCompiledMethodWithSize: bytecodeSize andHeader: methodHeader [ 
	
	"self objectMemory instantiateCompiledMethodClass: self methodClass target address indexableSize: bytecodeSize"
	
	^ (self
		executePrimitiveNumber: 79
		on: self methodClass
		withArguments: { self smallIntegerMirrorOn: bytecodeSize . self smallIntegerMirrorOn: methodHeader })
			value asMethodMirror
]

{ #category : #bootstrap }
EPSimulatorBackend >> createObjectWithFormat: classFormat withSize: aSize [
	
	^ self mirrorOnAddress: (simulator objectMemory 
		newBootstrapInstanceFromClassFormat: classFormat
		indexableSize: aSize)
]

{ #category : #bootstrap }
EPSimulatorBackend >> createObjectWithFormat: classFormat withSize: aSize classIndex: classIndex [
	
	| oop |
	oop := aSize = 0 ifTrue: [ 
		simulator objectMemory 
			newBootstrapInstanceFromClassFormat: classFormat
			classIndex: classIndex.
	] ifFalse: [ 
		simulator objectMemory 
			newBootstrapInstanceFromClassFormat: classFormat
			indexableSize: aSize
			classIndex: classIndex.
	].
	^ self mirrorOnAddress: oop.
]

{ #category : #primitives }
EPSimulatorBackend >> executePrimitiveMethod: aMethod on: receiver withArguments: aCollection [ 

	| returnValue |
	self simulator internalizeIPandSP.
	self simulator externalizeIPandSP.
	self simulator initPrimCall.
	self simulator argumentCount: aCollection size.
	self simulator push: receiver target address.
	aCollection do: [ :each |
		self simulator push: each target address.
	].

	
	^ [
		aMethod isNamedPrimitive
			ifTrue: [ | pragma function pluginName addr |
				pragma := aMethod pragmas detect: #isPrimitive.
				function := pragma arguments first value.
				pluginName := pragma arguments second value.
				addr := self simulator
					ioLoadFunction: function
					From: pluginName
					AccessorDepthInto: (CPluggableAccessor new
						setObject: nil;
						atBlock: [ :obj :idx | ]
						atPutBlock: [:obj :idx :val| ];
						yourself).
				self simulator callExternalPrimitive: addr.
				self simulator maybeRetryFailureDueToForwarding: 117.
				
				self simulator primitiveFailureCode > 0 ifTrue: [ 
					self halt.
					^ EPPrimitiveFailed new code: self simulator primitiveFailureCode ].
				
				returnValue := self simulator stackTop.
				self simulator pop: 1.
				^ EPPrimitiveSuccess new value: (self mirrorOnAddress: returnValue) 
			]
			ifFalse: [ | function |
				function := self simulator functionPointerFor: aMethod primitive inClass: nil.
				function = 0 ifTrue: [ ^ EPPrimitiveFailed new ].
				self simulator primitiveFunctionPointer: function.
				self simulator dispatchFunctionPointer: function.
				self simulator maybeRetryFailureDueToForwarding: aMethod primitive.
			].
			self simulator primitiveFailureCode > 0 ifTrue: [ 
				^ EPPrimitiveFailed new code: self simulator primitiveFailureCode ].
			
			returnValue := self simulator stackTop.
			self simulator pop: 1.
			^ EPPrimitiveSuccess new value: (self mirrorOnAddress: returnValue)
		] ensure: [ 
			"We pop extra things..."
			self simulator pop: (((self simulator stackPointer - self simulator framePointer) + (self simulator objectMemory wordSize * 5)) min: 0)  abs / self simulator objectMemory wordSize.
			self assert: self stackIsEmpty.
			"Recursive xeq affects primErrorCode"
			self simulator initPrimCall.
			self simulator internalizeIPandSP].
]

{ #category : #primitives }
EPSimulatorBackend >> executePrimitiveNumber: number on: receiver withArguments: aCollection [ 

	| returnValue |
	self simulator internalizeIPandSP.
	self simulator externalizeIPandSP.
	self simulator initPrimCall.
	self simulator argumentCount: aCollection size.
	self simulator push: receiver target address.
	aCollection do: [ :each |
		self simulator push: each target address.
	].

	
	^ [		| function |
			function := self simulator functionPointerFor: number inClass: nil.
			function = 0 ifTrue: [ ^ EPPrimitiveFailed new ].
			self simulator primitiveFunctionPointer: function.
			self simulator dispatchFunctionPointer: function.
			self simulator primitiveFailureCode > 0 ifTrue: [ 
				^ EPPrimitiveFailed new code: self simulator primitiveFailureCode ].
			
			returnValue := self simulator stackTop.
			self simulator pop: 1.
			^ EPPrimitiveSuccess new value: (self mirrorOnAddress: returnValue)
		] ensure: [ 
			"We pop extra things..."
			self simulator pop: (((self simulator stackPointer - self simulator framePointer) + (self simulator objectMemory wordSize*5)) min: 0)  abs / self simulator objectMemory wordSize.
			self assert: self stackIsEmpty.
			"Recursive xeq affects primErrorCode"
			self simulator initPrimCall.
			self simulator internalizeIPandSP].
]

{ #category : #accessing }
EPSimulatorBackend >> falseObject [
	
	"The first special object.
	Smalltalk specialObjectsArray indexOf: nil"
	^ self mirrorOnAddress: simulator objectMemory falseObject
]

{ #category : #'special objects' }
EPSimulatorBackend >> falseObject: anEPMirror [
	"The first special object.
	Smalltalk specialObjectsArray indexOf: nil"

	"^ self specialObjectsArray at: 1 put: anEPMirror"

	self specialObjectsArray
		ifNotNil: [ :soa | soa at: 2 put: anEPMirror ].
	simulator objectMemory falseObject: anEPMirror target address
]

{ #category : #'special objects' }
EPSimulatorBackend >> floatClass: aMirror [ 
	
	super floatClass: aMirror.
	self installClass: aMirror inClassTableIndex: 34.
]

{ #category : #'as yet unclassified' }
EPSimulatorBackend >> floatObject: anEPFloatMirror at: anInteger put: anEPMirror [ 
	
	self
		executePrimitiveNumber: 39
		on: anEPFloatMirror
		withArguments: { self smallIntegerMirrorOn: anInteger . anEPMirror }
]

{ #category : #bootstrap }
EPSimulatorBackend >> forBootstrap [

	self objectMemory
		allocateMemoryOfSize: 30 * 1024 * 1024 "10MB of old space"
		newSpaceSize: 50 * 1024 * 1024 "20MB of new space"
		stackSize: 16 * 1024
		codeSize: 0.
	"self objectMemory
		setHeapBase: self objectMemory startOfMemory
		memoryLimit: self objectMemory startOfMemory + (4 * 1024 * 1024)
		endOfMemory: self objectMemory startOfMemory + 16 * 1024."
	self objectMemory setCheckForLeaks: 15 - 6. "don't check become; or newSpace; soooo many rehashes in bootstrap"
	self objectMemory bootstrapping: true.
	self objectMemory lastHash: Object new basicIdentityHash.
	self objectMemory classTableIndex: 1024.
	self simulator thisClassIndex: 6. "we are in pharo"
	self simulator transcript: ThreadSafeTranscript new.
]

{ #category : #'as yet unclassified' }
EPSimulatorBackend >> fromLocalByteArray: aCollection [ 
	
	| remoteByteArray |
	remoteByteArray := (self byteArrayClass basicNew: aCollection size).
	1 to: aCollection size do: [ :i |
		remoteByteArray at: i put: (self smallIntegerMirrorOn: (aCollection at: i)). 
	].
	^ remoteByteArray
]

{ #category : #'as yet unclassified' }
EPSimulatorBackend >> fromLocalByteString: aString [ 
	
	| remoteString |
	remoteString := (self byteStringClass basicNew: aString size).
	1 to: aString size do: [ :i |
		remoteString at: i put: (self smallIntegerMirrorOn: (aString at: i) asciiValue). 
	].
	^ remoteString
]

{ #category : #converting }
EPSimulatorBackend >> fromLocalByteSymbol: aByteSymbol [

	| remoteSymbol |
	remoteSymbol := (self byteSymbolClass basicNew: aByteSymbol size).
	1 to: aByteSymbol size do: [ :i |
		remoteSymbol at: i put: (self smallIntegerMirrorOn: (aByteSymbol at: i) asciiValue). 
	].
	^ remoteSymbol
]

{ #category : #converting }
EPSimulatorBackend >> fromLocalCharacter: aCharacter [ 
	
	^ self mirrorOnAddress: (self objectMemory characterObjectOf: aCharacter codePoint)
]

{ #category : #'as yet unclassified' }
EPSimulatorBackend >> fromLocalFloat: aLocalFloat [ 
	
	^ self floatMirrorOn: (self handleOnAddress: (simulator objectMemory floatObjectOf: aLocalFloat))
]

{ #category : #transformations }
EPSimulatorBackend >> fromLocalInteger: aLocalInteger [
	
	| integer |
	integer := simulator objectMemory signedMachineIntegerFor: aLocalInteger.
	^ (simulator objectMemory isImmediate: integer)
		ifTrue: [ EPSimulatorSmallIntegerMirror on: (self handleOnAddress: integer) from: self ]
		ifFalse: [ self mirrorOnAddress: integer ].
]

{ #category : #'as yet unclassified' }
EPSimulatorBackend >> fromLocalNegativeInteger: anInteger [ 
	
	^ self fromLocalInteger: anInteger
	"| integerClassMirror integerMirror |
	integerClassMirror := self largeNegativeIntegerClass asClassMirror.
	integerMirror := (integerClassMirror basicNew: anInteger basicSize).
	1 to: anInteger basicSize do: [ :i | integerMirror at: i put: ((anInteger at: i) asLiteralInObjectSpace: self) ].
	^integerMirror"
]

{ #category : #'as yet unclassified' }
EPSimulatorBackend >> fromLocalPositiveInteger: anInteger [ 
	
	^ self fromLocalInteger: anInteger
	"| integerClassMirror integerMirror |
	integerClassMirror := self largeNegativeIntegerClass asClassMirror.
	integerMirror := (integerClassMirror basicNew: anInteger basicSize).
	1 to: anInteger basicSize do: [ :i | integerMirror at: i put: ((anInteger at: i) asLiteralInObjectSpace: self) ].
	^integerMirror"
]

{ #category : #'instance creation' }
EPSimulatorBackend >> fromRemoteByteString: anEPMirror [ 
	
	| localString |
	localString := ByteString new: anEPMirror basicSize.
	1 to: localString size do: [ :i |
		localString byteAt: i put: (anEPMirror byteAt: i).
	].
	^ localString
]

{ #category : #'as yet unclassified' }
EPSimulatorBackend >> fromRemoteByteSymbol: anEPMirror [ 
	
	
	^ Symbol intern: (self fromRemoteByteString: anEPMirror)
]

{ #category : #converting }
EPSimulatorBackend >> fromRemoteCharacter: aCharacterMirror [

	^ Character value: (self objectMemory characterValueOf: aCharacterMirror target address)
]

{ #category : #'as yet unclassified' }
EPSimulatorBackend >> fromSmallInteger: anInteger [ 
	
	^ self fromLocalInteger: anInteger
	"^ self smallIntegerMirrorOn: anInteger"
]

{ #category : #'special objects' }
EPSimulatorBackend >> fullBlockClass: aMirror [
	
	self installClass: aMirror inClassTableIndex: 38
]

{ #category : #'as yet unclassified' }
EPSimulatorBackend >> handleOnAddress: anAddress [

	^ EPSimulatorAddressHandle new
			backend: self;
			address: anAddress;
			yourself
]

{ #category : #'as yet unclassified' }
EPSimulatorBackend >> handleOnClassIndex: aClassIndex [

	^ EPSimulatorClassTableHandle new
			backend: self;
			classIndex: aClassIndex;
			yourself
]

{ #category : #'as yet unclassified' }
EPSimulatorBackend >> handleOnExternalObject: anObject [

	^ EPSimulatorExternalObjectHandle new
			backend: self;
			object: anObject;
			yourself
]

{ #category : #'as yet unclassified' }
EPSimulatorBackend >> hasPrimitiveFailed: anEPMirror [ 
	
	"if we arrived here is because the primitive did not fail"
	^ false
]

{ #category : #'as yet unclassified' }
EPSimulatorBackend >> headerOfCompiledMethod: anEPSimulatorAddressHandle [ 
	
	^ (self compiledMethod: anEPSimulatorAddressHandle objectAt: 1) asSmallInteger
]

{ #category : #'initialize-release' }
EPSimulatorBackend >> initialize [
	super initialize.
	extraRoots := Set new.
]

{ #category : #bootstrap }
EPSimulatorBackend >> initializeExecutionContext [

	| page pointer stackPages theIP theMethod rcvr numArgs |

"Create empty initial context to be able to execute primitives"
	stackPages := self simulator stackPages.
	page := stackPages newStackPage.
	pointer := page baseAddress.
	theIP := 0.
	theMethod := self nilObject target address.
	rcvr := self nilObject target address.
	numArgs := 0.
	
	"If this is a synthetic context its IP could be pointing at the CallPrimitive opcode.  If so, skip it."
	stackPages longAt: pointer put: rcvr.
	
	"saved caller ip is sender context in base frame"
	stackPages
		longAt: (pointer := pointer - self objectMemory wordSize)
		put: self nilObject target address.

	"base frame's saved fp is null"
	stackPages
		longAt: (pointer := pointer - self objectMemory wordSize)
		put: 0.
	page baseFP: pointer; headFP: pointer.

	stackPages
		longAt: (pointer := pointer - self objectMemory wordSize)
		put: theMethod.

	stackPages
		longAt: (pointer := pointer - self objectMemory wordSize)
		put: (self simulator encodeFrameFieldHasContext: true isBlock: true numArgs: numArgs).
	stackPages
		longAt: (pointer := pointer - self objectMemory wordSize)
		put: self nilObject target address.
	stackPages
		longAt: (pointer := pointer - self objectMemory wordSize)
		put: rcvr.
	
	"top of stack is the instruction pointer"
	stackPages longAt: (pointer := pointer - self objectMemory wordSize) put: theIP.
	page headSP: pointer.

	self simulator setStackPageAndLimit: page.
	self simulator framePointer: page headFP.
	self simulator stackPointer: page headSP.
	self simulator setMethodUnchecked: (self simulator iframeMethod: page headFP).
	self simulator instructionPointer: 0.
	self simulator internalizeIPandSP.
]

{ #category : #'as yet unclassified' }
EPSimulatorBackend >> initializeTempsInStackOfContext: anEPContextMirror [ 
	
	^ self executePrimitiveNumber: 76 on: anEPContextMirror withArguments: { self smallIntegerMirrorOn: anEPContextMirror method numberOfTemps }
]

{ #category : #'as yet unclassified' }
EPSimulatorBackend >> instSpecOfClass: anEPClassMirror [ 
	
	^ self simulator objectMemory instSpecOfClass: anEPClassMirror target address
]

{ #category : #'as yet unclassified' }
EPSimulatorBackend >> installClass: aMirror inClassTableIndex: anInteger [ 
	
	self objectMemory setHashBitsOf: aMirror target address to: anInteger.
	self objectMemory classAtIndex: anInteger putUnchecked: aMirror target address.
	aMirror target: aMirror target asClassIndexHandle.
]

{ #category : #'as yet unclassified' }
EPSimulatorBackend >> instanceFixedSizeOf: aClass [
	
	^ aClass format bitAnd: 16rFFFF
]

{ #category : #'as yet unclassified' }
EPSimulatorBackend >> integerValueOf: anEPMirror [ 
	
	^ self objectMemory integerValueOf: anEPMirror target address
]

{ #category : #'as yet unclassified' }
EPSimulatorBackend >> isBitsClass: anEPClassMirror [ 
	
	^ (self instSpecOfClass: anEPClassMirror) >= 7
]

{ #category : #testing }
EPSimulatorBackend >> isForwarderAddress: anInteger [ 
	
	^ simulator objectMemory isForwarded: anInteger
]

{ #category : #testing }
EPSimulatorBackend >> isSmallInteger: aHandle [ 
	
	^ self objectMemory isIntegerObject: aHandle address
]

{ #category : #'special objects' }
EPSimulatorBackend >> largeNegativeIntegerClass: aMirror [ 
	
	super largeNegativeIntegerClass: aMirror.
	self installClass: aMirror inClassTableIndex: 32.
]

{ #category : #'special objects' }
EPSimulatorBackend >> largePositiveIntegerClass: aMirror [ 
	
	super largePositiveIntegerClass: aMirror.
	self installClass: aMirror inClassTableIndex: 33
]

{ #category : #'special objects' }
EPSimulatorBackend >> messageClass: aMirror [ 
	
	super messageClass: aMirror.
	self installClass: aMirror inClassTableIndex: 35.
]

{ #category : #accessing }
EPSimulatorBackend >> minSmallInteger [

	^ simulator objectMemory minSmallInteger
]

{ #category : #mirrors }
EPSimulatorBackend >> mirrorOnAddress: anObject [
	
	^ self mirrorOn: (self handleOnAddress: anObject)
]

{ #category : #'as yet unclassified' }
EPSimulatorBackend >> mirrorOnExternalHandle: anObject [
	
	^ self mirrorOn: (self handleOnExternalObject: anObject)
]

{ #category : #accessing }
EPSimulatorBackend >> nilObject [
	
	"The first special object.
	Smalltalk specialObjectsArray indexOf: nil"
	^ self mirrorOnAddress: simulator objectMemory nilObject
]

{ #category : #'special objects' }
EPSimulatorBackend >> nilObject: anEPMirror [
	"The first special object.
	Smalltalk specialObjectsArray indexOf: nil"

	self specialObjectsArray
		ifNotNil: [ :soa | soa at: 1 put: anEPMirror ].
	simulator objectMemory nilObject: anEPMirror target address
]

{ #category : #primitives }
EPSimulatorBackend >> object: anObject at: anInteger [
	
	^ self mirrorOnAddress: (simulator stObject: anObject address at: anInteger)
]

{ #category : #primitives }
EPSimulatorBackend >> object: anObject at: anInteger put: aValue [
	
	simulator objectMemory
		stObject: anObject
		at: anInteger
		put: aValue
]

{ #category : #primitives }
EPSimulatorBackend >> object: anObject byteAt: anInteger [
	
	^ simulator objectMemory fetchByte: anInteger ofObject: anObject address
]

{ #category : #primitives }
EPSimulatorBackend >> object: anObject instVarAt: index [ 
	
	| address |
	address := self objectMemory fetchPointer: index - 1 ofObject: anObject target address.	
	((self objectMemory isNonImmediate: address)
		and: [self objectMemory isForwarded: address])
			ifTrue: [ | forwardedObject |
				forwardedObject := self objectMemory followForwarded: address.
				self object: anObject address instVarAt: index put: forwardedObject.
				address := forwardedObject ].
	^ self mirrorOnAddress: address
]

{ #category : #primitives }
EPSimulatorBackend >> object: object instVarAt: index put: aValue [
	
	simulator objectMemory storePointer: index - 1 ofObject: object withValue: aValue
]

{ #category : #primitives }
EPSimulatorBackend >> object: anObject uncheckedAt: anInteger [
	
	^ self mirrorOnAddress: (simulator objectMemory
		fetchPointer: anInteger
		ofObject: anObject address)
]

{ #category : #accessing }
EPSimulatorBackend >> objectMemory [
	
	^ simulator objectMemory
]

{ #category : #'special objects' }
EPSimulatorBackend >> pointClass: aMirror [ 
	
	super pointClass: aMirror.
	self installClass: aMirror inClassTableIndex: 54.
]

{ #category : #primitives }
EPSimulatorBackend >> rawHashOf: aMirror [
	
	"this method does not initialize the hash of the object"
	
	^ self objectMemory rawHashBitsOf: aMirror target
]

{ #category : #'special objects' }
EPSimulatorBackend >> semaphoreClass: aMirror [ 
	
	super semaphoreClass: aMirror.
	self installClass: aMirror inClassTableIndex: 48.
]

{ #category : #accessing }
EPSimulatorBackend >> simulator [
	^ simulator
]

{ #category : #accessing }
EPSimulatorBackend >> simulator: aSimulator [ 
	
	simulator := aSimulator
]

{ #category : #'special objects' }
EPSimulatorBackend >> smallFloatClass: aClass [

	"SmallFloat is a special class that resides in the first page of the class table.
	
	Usually, a class hash must be the same as the class index in the class table. 
	To install the class in the table in both positions, we use an Unchecked version of the method that contains no assertions of that invariant.
	
	Also the hash of the class is set to 4, following the current behavior of the system:
	
	SmallFloat64 basicIdentityHash."

	self objectMemory setHashBitsOf: aClass target address to: 4.
	self objectMemory classAtIndex: 4 putUnchecked: aClass target address.
	aClass target: aClass target asClassIndexHandle.
]

{ #category : #'special objects' }
EPSimulatorBackend >> smallIntegerClass: aClass [

	super smallIntegerClass: aClass.
	
	"SmallInteger is a special class that resides in the first page of the class table.
	For some reason that we ignore so far, this class is in two different indexes of the table: 1 and 3.
	
	Usually, a class hash must be the same as the class index in the class table. But, since the class is in two different positions, one of them does not hold that invariant.
	To install the class in the table in both positions, we use an Unchecked version of the method that contains no assertions of that invariant.
	
	Also the hash of the class is set to 1, following the current behavior of the system:
	
	SmallInteger basicIdentityHash."
	self objectMemory setHashBitsOf: aClass target address to: 1.
	self objectMemory classAtIndex: 1 putUnchecked: aClass target address.
	self objectMemory classAtIndex: 3 putUnchecked: aClass target address.
	aClass target: aClass target asClassIndexHandle.
]

{ #category : #mirrors }
EPSimulatorBackend >> smallIntegerMirrorOn: anInteger [ 
	
	^ EPSimulatorSmallIntegerMirror on: (self handleOnAddress: (self objectMemory integerObjectOf: anInteger)) from: self
]

{ #category : #'special objects' }
EPSimulatorBackend >> specialObjectsArray: aMirror [ 
	
	specialObjectsArray := aMirror.
	simulator objectMemory specialObjectsOop: aMirror target address.
]

{ #category : #'as yet unclassified' }
EPSimulatorBackend >> stackIsEmpty [
	
	"We have an initial stack of 20"
	^ self simulator stackPointer - self simulator framePointer == (self simulator objectMemory wordSize * 5) negated
]

{ #category : #accessing }
EPSimulatorBackend >> trueObject [
	
	"The first special object.
	Smalltalk specialObjectsArray indexOf: nil"
	^ self mirrorOnAddress: simulator objectMemory trueObject
]

{ #category : #'special objects' }
EPSimulatorBackend >> trueObject: anEPMirror [
	"The first special object.
	Smalltalk specialObjectsArray indexOf: nil"

	"^ self specialObjectsArray at: 1 put: anEPMirror"

	self specialObjectsArray
		ifNotNil: [ :soa | soa at: 3 put: anEPMirror ].
	simulator objectMemory trueObject: anEPMirror target address
]

{ #category : #accessing }
EPSimulatorBackend >> wordSize [
	
	"for now"
	^ simulator objectMemory wordSize
]
