"
I am a mirror object providing basic operations to work on objects inside an object space.
"
Class {
	#name : 'EPMirror',
	#superclass : 'Object',
	#instVars : [
		'target',
		'backend'
	],
	#category : 'Espell-LowLevel-Mirrors',
	#package : 'Espell',
	#tag : 'LowLevel-Mirrors'
}

{ #category : 'instance creation' }
EPMirror class >> on: aTargetObject [
	self error: 'specify object space.'.
	^self new target: aTargetObject; yourself
]

{ #category : 'instance creation' }
EPMirror class >> on: aTargetObject from: aBackend [
	^self new
		target: aTargetObject;
		backend: aBackend;
		yourself
]

{ #category : 'comparing' }
EPMirror >> = anotherMirror [
	
	(anotherMirror isKindOf: self class) ifFalse: [ ^ false ].
	
	anotherMirror isOzMirror ifFalse: [ ^ false ].
	
	^ self pointsToSameObject: anotherMirror
]

{ #category : 'converting' }
EPMirror >> asBoolean [

	^ backend fromRemoteBoolean: self
]

{ #category : 'converting' }
EPMirror >> asClassMirror [

	^backend classMirrorOn: self target
]

{ #category : 'converting' }
EPMirror >> asContextMirror [
	
	^backend contextMirrorOn: self target
]

{ #category : 'converting' }
EPMirror >> asFloatMirror [

	^backend floatMirrorOn: self target
]

{ #category : 'converting' }
EPMirror >> asLocalLiteral [
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
]

{ #category : 'converting' }
EPMirror >> asLocalString [
	
	^ backend fromRemoteByteString: self.
]

{ #category : 'converting' }
EPMirror >> asMethodMirror [

	^backend methodMirrorOn: self target
]

{ #category : 'converting' }
EPMirror >> asProcessMirror [

	^backend processMirrorOn: self target
]

{ #category : 'converting' }
EPMirror >> asRemoteClassOrTraitFromEnvironment: anEPRemoteEnvironment [
	^ EPRemoteClass 
		on: self
		environment: anEPRemoteEnvironment
		
]

{ #category : 'converting' }
EPMirror >> asSchedulerMirror [
	
	^ backend processSchedulerMirrorOn: self target
]

{ #category : 'converting' }
EPMirror >> asSmallInteger [
	"Use carefully"
	^ backend integerValueOf: self
]

{ #category : 'converting' }
EPMirror >> asTraitMirror [
	
	^backend traitMirrorOn: self target
]

{ #category : 'accessing' }
EPMirror >> at: anIndex [

	^ backend object: target at: anIndex
]

{ #category : 'accessing' }
EPMirror >> at: anIndex put: aMirror [

	backend object: target address at: anIndex put: aMirror target address
]

{ #category : 'initialize-release' }
EPMirror >> backend [

	^ backend
]

{ #category : 'initialize-release' }
EPMirror >> backend: aBackend [

	backend := aBackend
]

{ #category : 'accessing' }
EPMirror >> basicAt: anIndex [
	^self at: anIndex
]

{ #category : 'accessing' }
EPMirror >> basicAt: anIndex put: anObject [
	self at: anIndex put: anObject
]

{ #category : 'accessing' }
EPMirror >> basicClass [
	
	^ backend classMirrorOn: self target basicClass
]

{ #category : 'comparing' }
EPMirror >> basicIdentityHash [

	^ backend basicIdentityHashOf: self
]

{ #category : 'accessing' }
EPMirror >> basicSize [
	
	^ backend basicSizeOf: self
]

{ #category : 'special' }
EPMirror >> becomeInto: anObjectMirror [

	backend become: self into: anObjectMirror
]

{ #category : 'accessing' }
EPMirror >> byteAt: anIndex [

	^ backend object: target byteAt: anIndex - 1
]

{ #category : 'special' }
EPMirror >> copy [

	"If we put everything in one line it sends the #mirrorOn: message to self O_o... bug?"
	| copy |
	copy := self copy: target.
	^ backend mirrorOn: copy
]

{ #category : 'private' }
EPMirror >> copy: handle [
	
	<primitive: 148>
]

{ #category : 'special' }
EPMirror >> executePrimitive: number [

	^ self executePrimitive: number withArgs: #()
]

{ #category : 'special' }
EPMirror >> executePrimitive: number withArgs: args [

	| result |
	result := backend
		handle: target
		executePrimitive: number
		withArgs: args.
	^ backend mirrorOn: result
]

{ #category : 'special' }
EPMirror >> executePrimitiveMethod: aCompiledMethod withArguments: arguments [

	| result |
	result := self backend
			executePrimitiveMethod: aCompiledMethod
			on: self
			withArguments: arguments.
	
	self assert: self backend stackIsEmpty. 
	^ result.
]

{ #category : 'public api' }
EPMirror >> fixedSize [
	^self basicClass instanceFixedSize
]

{ #category : 'public api' }
EPMirror >> getClass [
	
	| mirror |
	self deprecated: 'Use #basicClass instead'.
	mirror := self basicClass.
	^ mirror isClassSide
			ifTrue: [ mirror asMetaclassMirror ]
			ifFalse: [ mirror ]
]

{ #category : 'comparing' }
EPMirror >> hash [

	^ self identityHash
]

{ #category : 'comparing' }
EPMirror >> identityHash [

	^ self isSmallInteger
		ifTrue: [ self target asSmallInteger hashMultiply ]
		ifFalse: [ self basicIdentityHash bitShift: 18 ]
]

{ #category : 'accessing' }
EPMirror >> instanceVariableAtIndex: index [

	^ target instanceVariableAtIndex: index
]

{ #category : 'accessing' }
EPMirror >> instanceVariableAtIndex: index put: aReference [
	
	backend object: target address instVarAt: index put: aReference target address
]

{ #category : 'accessing' }
EPMirror >> instanceVariableMapping [
	^ self backend instanceVariableMapping
]

{ #category : 'testing' }
EPMirror >> isMethodContextClass [
	
	^ backend contextClass pointsToSameObject: self
]

{ #category : 'testing' }
EPMirror >> isMethodProperties [

	self halt.
	^ self objectSpace isMethodProperties: self
]

{ #category : 'testing' }
EPMirror >> isNilObject [
	
	^ backend nilObject pointsToSameObject: self
]

{ #category : 'testing' }
EPMirror >> isOzMirror [

	^ true
]

{ #category : 'printing' }
EPMirror >> isSelfEvaluating [

	^ false
]

{ #category : 'testing' }
EPMirror >> isSmallInteger [
	
	^ target isSmallInteger
]

{ #category : 'printing' }
EPMirror >> longPrintOn: aStream limitedTo: sizeLimit indent: indent [

	^ self printOn: aStream
]

{ #category : 'private' }
EPMirror >> markExperimentalBit: aBoolean [
	
	self executePrimitive: 96 withArgs: { aBoolean }.
]

{ #category : 'comparing' }
EPMirror >> pointsToSameObject: aMirror [
	^self target = aMirror target
]

{ #category : 'private' }
EPMirror >> primitiveClass [

	"this method is very special. You should not call it if you don't know exactly what you are doing.
	Warning said, this is the meaning of this method:
		
		This method returns the pointer of the class of the handle, as it is understood *by the VM*.
		That means, instances of compact classes (i.e., Array, Association) will return the class from the Host image ALWAYS"
	
	^ (self executePrimitive: 111) target
]

{ #category : 'printing' }
EPMirror >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPutAll: '(';
		nextPutAll: self identityHash asString;
		nextPutAll: ')'
]

{ #category : 'public api' }
EPMirror >> setClass: aClassMirror [
	[
		backend classHandle: aClassMirror target setTo: self target
	] on: PrimitiveFailed do: [ 
		(aClassMirror format ~= self basicClass format) ifTrue: [ 
			self error: ('format of instance {1} of format {2} should match class format: {3} ' 
				format: { self printString . self basicClass format . aClassMirror format asString })
		].
	]
]

{ #category : 'printing' }
EPMirror >> shouldBePrintedAsLiteral [

	^ false
]

{ #category : 'public api' }
EPMirror >> size [
	
	^ self basicSize
]

{ #category : 'initialize-release' }
EPMirror >> target [

	^target
]

{ #category : 'initialize-release' }
EPMirror >> target: aTargetObject [

	target := aTargetObject
]

{ #category : 'accessing' }
EPMirror >> uncheckedAt: anIndex [

	^ backend object: target uncheckedAt: anIndex - 1
]

{ #category : 'public api' }
EPMirror >> value [
	self deprecated: 'This was meant for associations'.
	^self instanceVariableAtIndex: 2
]

{ #category : 'public api' }
EPMirror >> variableSize [

	self deprecated: 'Use #basicSize'.
	^ (self basicClass = self objectSpace contextClass
		ifTrue: [ self asContextMirror ]
		ifFalse: [ self ]) basicSize.
]
