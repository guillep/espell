"
I am an abstract backend for Espell object spaces. I implement
- the management of the special objects array
"
Class {
	#name : 'EPBackend',
	#superclass : 'Object',
	#instVars : [
		'interpreter',
		'specialObjectsArray',
		'byteSymbolClass',
		'associationClass',
		'symbolTableClass',
		'byteSymbolMapping',
		'largePositiveIntegerMapping',
		'largeNegativeIntegerMapping',
		'instanceVariableMapping',
		'compiledBlockClass'
	],
	#category : 'Espell-LowLevel-Mirrors',
	#package : 'Espell',
	#tag : 'LowLevel-Mirrors'
}

{ #category : 'special objects' }
EPBackend >> arrayClass [

	"The Array class in special objects arrays.
	Smalltalk specialObjectsArray indexOf: Array"
	^ (specialObjectsArray at: 8) asClassMirror
]

{ #category : 'special objects' }
EPBackend >> arrayClass: aClass [

	"The Array class in special objects arrays.
	Smalltalk specialObjectsArray indexOf: Array"
	^ specialObjectsArray at: 8 put: aClass
]

{ #category : 'special objects' }
EPBackend >> associationClass [
	"The class of the fourth special object
	Smalltalk specialObjectsArray fourth class"
	^ associationClass ifNil: [ (self specialObjectsArray at: 4) basicClass ]
]

{ #category : 'special objects' }
EPBackend >> associationClass: aClass [
	
	associationClass := aClass
]

{ #category : 'as yet unclassified' }
EPBackend >> basicIdentityHashOnClass: anEPClassMirror [ 
	
	self subclassResponsibility
]

{ #category : 'as yet unclassified' }
EPBackend >> basicNewOn: anEPClassMirror [ 

	self subclassResponsibility
]

{ #category : 'as yet unclassified' }
EPBackend >> basicNewOn: anEPClassMirror withSize: anEPSimulatorSmallIntegerMirror [ 
	
	self subclassResponsibility
]

{ #category : 'primitives' }
EPBackend >> basicSizeOf: anEPMirror [ 
	
	self subclassResponsibility
]

{ #category : 'as yet unclassified' }
EPBackend >> become: anEPClassMirror into: anEPClassMirror2 [ 
	
	self subclassResponsibility
]

{ #category : 'special objects' }
EPBackend >> blockClass [

	"The Point class in most special objects arrays.
	Smalltalk specialObjectsArray indexOf: BlockClosure"
	^ specialObjectsArray at: 37
]

{ #category : 'special objects' }
EPBackend >> blockClass: aClass [

	"The Point class in most special objects arrays.
	Smalltalk specialObjectsArray indexOf: BlockClosure"
	^ specialObjectsArray at: 37 put: aClass
]

{ #category : 'special objects' }
EPBackend >> byteArrayClass [
	"The twenty-seventh special object.
	Smalltalk specialObjectsArray indexOf: ByteArray"
	^ (self specialObjectsArray at: 27) asClassMirror
]

{ #category : 'special objects' }
EPBackend >> byteArrayClass: aClass [
	"The twenty-seventh special object.
	Smalltalk specialObjectsArray indexOf: ByteArray"
	^ self specialObjectsArray at: 27 put: aClass
]

{ #category : 'special objects' }
EPBackend >> byteStringClass [
	"The seventh special object.
	Smalltalk specialObjectsArray indexOf: ByteString"
	^ (self specialObjectsArray at: 7) asClassMirror
]

{ #category : 'special objects' }
EPBackend >> byteStringClass: aClass [
	"The seventh special object.
	Smalltalk specialObjectsArray indexOf: ByteString"
	^ self specialObjectsArray at: 7 put: aClass
]

{ #category : 'special objects' }
EPBackend >> byteSymbolClass [
	
	"The most common symbol. Symbol with byte-length characters"
	^ byteSymbolClass ifNil: [ (self arrayClass instanceVariableAtIndex: self simulator classNameIndex) basicClass ]
]

{ #category : 'special objects' }
EPBackend >> byteSymbolClass: aClass [
	
	byteSymbolClass := aClass
]

{ #category : 'special objects' }
EPBackend >> characterClass [
	"The twentieth special object.
	Smalltalk specialObjectsArray indexOf: Character"
	^ self specialObjectsArray at: 20
]

{ #category : 'special objects' }
EPBackend >> characterClass: aClass [
	"The twentieth special object.
	Smalltalk specialObjectsArray indexOf: Character"
	^ self specialObjectsArray at: 20 put: aClass
]

{ #category : 'special objects' }
EPBackend >> characterTable [
	
	"The Character table instance in most special objects arrays.
	Smalltalk specialObjectsArray indexOf: Character characterTable"
	
	^ specialObjectsArray at: 25
]

{ #category : 'special objects' }
EPBackend >> characterTable: aTable [
	
	"The Character table instance in most special objects arrays.
	Smalltalk specialObjectsArray indexOf: Character characterTable"
	
	^ specialObjectsArray at: 25 put: aTable
]

{ #category : 'as yet unclassified' }
EPBackend >> classHandle: anInteger setTo: anInteger2 [ 
	
	self subclassResponsibility
]

{ #category : 'mirrors' }
EPBackend >> classMirrorOn: anObject [
	
	^ EPClassMirror on: anObject from: self
]

{ #category : 'as yet unclassified' }
EPBackend >> compactClassIndexOf: anEPClassMirror [ 
	self subclassResponsibility
]

{ #category : 'special objects' }
EPBackend >> compiledBlockClass [

	^ compiledBlockClass
]

{ #category : 'special objects' }
EPBackend >> compiledBlockClass: aMirror [

	compiledBlockClass := aMirror
]

{ #category : 'as yet unclassified' }
EPBackend >> compiledMethod: anEPVMCompiledMethodMirror objectAt: anInteger [ 
	
	self subclassResponsibility
]

{ #category : 'as yet unclassified' }
EPBackend >> compiledMethod: anEPVMCompiledMethodMirror objectAt: anInteger put: anEPMirror [ 
	
	self subclassResponsibility 
]

{ #category : 'special objects' }
EPBackend >> contextClass [

	"The method Comtext class in most special objects arrays.
	Smalltalk specialObjectsArray indexOf: Context"
	^ specialObjectsArray at: 11
]

{ #category : 'special objects' }
EPBackend >> contextClass: anEPClassMirror [ 

	"The method Comtext class in most special objects arrays.
	Smalltalk specialObjectsArray indexOf: Context"
	^ specialObjectsArray at: 11 put: anEPClassMirror 
]

{ #category : 'mirrors' }
EPBackend >> contextMirrorOn: anObject [
	
	^ EPContextMirror on: anObject from: self
]

{ #category : 'as yet unclassified' }
EPBackend >> contextSizeOf: anEPContextMirror [ 
	self subclassResponsibility 
]

{ #category : 'as yet unclassified' }
EPBackend >> createCompiledMethodWithSize: anInteger andHeader: anInteger2 [ 
	
	self subclassResponsibility
]

{ #category : 'bootstrap' }
EPBackend >> createObjectWithFormat: aClassFormat withSize: aSize [

	self subclassResponsibility
]

{ #category : 'special objects' }
EPBackend >> falseObject [
	"The second special object.
	Smalltalk specialObjectsArray indexOf: false"
	^ self specialObjectsArray at: 2
]

{ #category : 'special objects' }
EPBackend >> falseObject: anEPMirror [ 
	"The second special object.
	Smalltalk specialObjectsArray indexOf: false"
	^ self specialObjectsArray at: 2	put: anEPMirror
]

{ #category : 'special objects' }
EPBackend >> floatClass [
	"The tenth special object.
	Smalltalk specialObjectsArray indexOf: Float"
	^ self specialObjectsArray at: 10
]

{ #category : 'special objects' }
EPBackend >> floatClass: aClass [
	"The tenth special object.
	Smalltalk specialObjectsArray indexOf: Float"
	^ self specialObjectsArray at: 10 put: aClass
]

{ #category : 'mirrors' }
EPBackend >> floatMirrorOn: anObject [
	
	^ EPFloatMirror on: anObject from: self
]

{ #category : 'as yet unclassified' }
EPBackend >> floatObject: anEPFloatMirror at: anInteger put: anEPMirror [ 
	self subclassResponsibility.
]

{ #category : 'as yet unclassified' }
EPBackend >> fromLocalByteArray: aCollection [ 
	
	self subclassResponsibility 
]

{ #category : 'as yet unclassified' }
EPBackend >> fromLocalByteString: aString [ 
	
	self subclassResponsibility
]

{ #category : 'converting' }
EPBackend >> fromLocalByteSymbol: aByteSymbol [

	self subclassResponsibility
]

{ #category : 'as yet unclassified' }
EPBackend >> fromLocalFloat: aNumber [ 
	
	self subclassResponsibility
]

{ #category : 'as yet unclassified' }
EPBackend >> fromLocalNegativeInteger: anInteger [ 
	self subclassResponsibility 
]

{ #category : 'converting' }
EPBackend >> fromLocalPositiveInteger: aPositiveInteger [

	| integerClassMirror integerMirror |
	integerClassMirror := self largePositiveIntegerClass asClassMirror.
	integerMirror := (integerClassMirror basicNew: aPositiveInteger basicSize).
	1 to: aPositiveInteger basicSize do: [ :i | integerMirror at: i put: ((aPositiveInteger at: i) asLiteralInObjectSpace: self) ].
	^integerMirror
]

{ #category : 'as yet unclassified' }
EPBackend >> fromRemoteByteString: anEPMirror [ 
	
	self subclassResponsibility
]

{ #category : 'as yet unclassified' }
EPBackend >> fromRemoteByteSymbol: anEPMirror [ 
	
	self subclassResponsibility
]

{ #category : 'as yet unclassified' }
EPBackend >> fromSmallInteger: anInteger [

	self subclassResponsibility
]

{ #category : 'special objects' }
EPBackend >> fullBlockClass: aClass [

	
]

{ #category : 'as yet unclassified' }
EPBackend >> hasPrimitiveFailed: anEPMirror [ 
	
	self subclassResponsibility
]

{ #category : 'as yet unclassified' }
EPBackend >> headerOfCompiledMethod: anEPSimulatorAddressHandle [ 
	self subclassResponsibility
]

{ #category : 'initialize-release' }
EPBackend >> initialize [

	super initialize.
	
	byteSymbolMapping := EPByteSymbolMapping new objectSpace: self; yourself.
	largeNegativeIntegerMapping := EPLargeNegativeIntegerMapping new objectSpace: self; yourself.
	largePositiveIntegerMapping := EPLargePositiveIntegerMapping new objectSpace: self; yourself.
	instanceVariableMapping := EPInstanceVariableMapping new.
]

{ #category : 'as yet unclassified' }
EPBackend >> initializeTempsInStackOfContext: anEPContextMirror [ 
	self subclassResponsibility.
]

{ #category : 'as yet unclassified' }
EPBackend >> instSpecOfClass: anEPClassMirror [ 
	
	self subclassResponsibility
]

{ #category : 'as yet unclassified' }
EPBackend >> instanceFixedSizeOf: anEPClassMirror [ 
	
	self subclassResponsibility 
]

{ #category : 'accessing' }
EPBackend >> instanceVariableMapping [
	^ instanceVariableMapping
]

{ #category : 'accessing' }
EPBackend >> instanceVariableMapping: anObject [
	instanceVariableMapping := anObject
]

{ #category : 'as yet unclassified' }
EPBackend >> integerValueOf: anEPMirror [ 
	
	self subclassResponsibility
]

{ #category : 'initialize-release' }
EPBackend >> interpreter [

	^ interpreter
]

{ #category : 'initialize-release' }
EPBackend >> interpreter: anInterpreter [

	interpreter := anInterpreter
]

{ #category : 'as yet unclassified' }
EPBackend >> isBitsClass: anEPClassMirror [ 
	
	self subclassResponsibility
]

{ #category : 'special objects' }
EPBackend >> largeNegativeIntegerClass [
	"The forty-third special object.
	Smalltalk specialObjectsArray indexOf: LargeNegativeInteger"
	^ self specialObjectsArray at: 43
]

{ #category : 'special objects' }
EPBackend >> largeNegativeIntegerClass: aClass [
	"The forty-third special object.
	Smalltalk specialObjectsArray indexOf: LargeNegativeInteger"
	^ self specialObjectsArray at: 43 put: aClass
]

{ #category : 'special objects' }
EPBackend >> largePositiveIntegerClass [
	"The fourteenth special object.
	Smalltalk specialObjectsArray indexOf: LargePositiveInteger"
	^ self specialObjectsArray at: 14
]

{ #category : 'special objects' }
EPBackend >> largePositiveIntegerClass: aClass [
	"The fourteenth special object.
	Smalltalk specialObjectsArray indexOf: LargePositiveInteger"
	^ self specialObjectsArray at: 14 put: aClass
]

{ #category : 'special objects' }
EPBackend >> messageClass [

	"The method Comtext class in most special objects arrays.
	Smalltalk specialObjectsArray indexOf: Message"
	^ specialObjectsArray at: 16
]

{ #category : 'special objects' }
EPBackend >> messageClass: aClass [

	"The method Comtext class in most special objects arrays.
	Smalltalk specialObjectsArray indexOf: Message"
	^ specialObjectsArray at: 16 put: aClass
]

{ #category : 'special objects' }
EPBackend >> methodClass [

	"The CompiledMethod instance in most special objects arrays.
	Smalltalk specialObjectsArray indexOf: CompiledMethod"
	^ specialObjectsArray at: 17
]

{ #category : 'special objects' }
EPBackend >> methodClass: anEPClassMirror [ 

	"The CompiledMethod instance in most special objects arrays.
	Smalltalk specialObjectsArray indexOf: CompiledMethod"
	^ specialObjectsArray at: 17 put: anEPClassMirror
]

{ #category : 'mirrors' }
EPBackend >> methodMirrorOn: aMethod [ 
	
	^ EPVMCompiledMethodMirror on: aMethod from: self
]

{ #category : 'mirrors' }
EPBackend >> mirrorOn: anObject [
	
	^ EPMirror on: anObject from: self
]

{ #category : 'special objects' }
EPBackend >> nilObject [
	
	"The first special object.
	Smalltalk specialObjectsArray indexOf: nil"
	^ self specialObjectsArray at: 1
]

{ #category : 'special objects' }
EPBackend >> nilObject: anEPMirror [ 
	
	"The first special object.
	Smalltalk specialObjectsArray indexOf: nil"
	^ self specialObjectsArray at: 1 put: anEPMirror
]

{ #category : 'as yet unclassified' }
EPBackend >> numberOfLiteralsOf: anEPSimulatorAddressHandle [ 
	
	^ (self headerOfCompiledMethod: anEPSimulatorAddressHandle) bitAnd: 16r7FFF
]

{ #category : 'primitives' }
EPBackend >> object: aHandle at: anIndex [
 
	self subclassResponsibility
]

{ #category : 'primitives' }
EPBackend >> object: anObject at: aKey put: aValue [
	
	self subclassResponsibility
]

{ #category : 'special objects' }
EPBackend >> pointClass [

	"The Point class in most special objects arrays.
	Smalltalk specialObjectsArray indexOf: Point"
	^ specialObjectsArray at: 13
]

{ #category : 'special objects' }
EPBackend >> pointClass: aClass [

	"The Point class in most special objects arrays.
	Smalltalk specialObjectsArray indexOf: Point"
	^ specialObjectsArray at: 13 put: aClass
]

{ #category : 'special objects' }
EPBackend >> processClass [

	"The Point class in most special objects arrays.
	Smalltalk specialObjectsArray indexOf: Process"
	^ specialObjectsArray at: 28
]

{ #category : 'special objects' }
EPBackend >> processClass: aClass [

	"The Point class in most special objects arrays.
	Smalltalk specialObjectsArray indexOf: Process"
	^ specialObjectsArray at: 28 put: aClass
]

{ #category : 'mirrors' }
EPBackend >> processMirrorOn: anObject [
	
	^ EPProcessMirror on: anObject from: self
]

{ #category : 'mirrors' }
EPBackend >> processSchedulerMirrorOn: anObject [
	
	^ EPProcessSchedulerMirror on: anObject from: self
]

{ #category : 'special objects' }
EPBackend >> processorAssociation [

	"The Association object that references the processor.
	Should be index 4.
	Smalltalk specialObjectsArray indexOf: (Smalltalk bindingOf: #Processor)"
	^ specialObjectsArray at: 4
]

{ #category : 'special objects' }
EPBackend >> processorAssociation: anAssociation [

	"The Association object that references the processor.
	Should be index 4.
	Smalltalk specialObjectsArray indexOf: (Smalltalk bindingOf: #Processor)"
	^ specialObjectsArray at: 4 put: anAssociation
]

{ #category : 'special objects' }
EPBackend >> semaphoreClass [

	"The Point class in most special objects arrays.
	Smalltalk specialObjectsArray indexOf: Semaphore"
	^ specialObjectsArray at: 19
]

{ #category : 'special objects' }
EPBackend >> semaphoreClass: aClass [

	"The Point class in most special objects arrays.
	Smalltalk specialObjectsArray indexOf: Semaphore"
	^ specialObjectsArray at: 19 put: aClass
]

{ #category : 'special objects' }
EPBackend >> smallIntegerClass [

	"The Smalltalk instance in most special objects arrays.
	Smalltalk specialObjectsArray indexOf: SmallInteger"
	^ self specialObjectsArray at: 6
]

{ #category : 'special objects' }
EPBackend >> smallIntegerClass: aClass [

	"The Smalltalk instance in most special objects arrays.
	Smalltalk specialObjectsArray indexOf: SmallInteger"
	^ specialObjectsArray at: 6 put: aClass
]

{ #category : 'mirrors' }
EPBackend >> smallIntegerMirrorOn: anInteger [ 
	
	self subclassResponsibility
]

{ #category : 'special objects' }
EPBackend >> smalltalkInstance [

	"The Smalltalk instance in most special objects arrays.
	Smalltalk specialObjectsArray indexOf: Smalltalk"
	^ specialObjectsArray at: 9.
	
]

{ #category : 'special objects' }
EPBackend >> smalltalkInstance: aMirror [

	"The Smalltalk instance in most special objects arrays.
	Smalltalk specialObjectsArray indexOf: Smalltalk"
	^ specialObjectsArray at: 9 put: aMirror
]

{ #category : 'special objects' }
EPBackend >> specialObjectsArray [
	"Careful. This is an external object. Do not send messages to it."
	^ specialObjectsArray
]

{ #category : 'special objects' }
EPBackend >> specialObjectsArray: aSpecialObjectsArray [

	specialObjectsArray := aSpecialObjectsArray
]

{ #category : 'special objects' }
EPBackend >> specialSelectors: anArrayOfSelectorsAndArgumentSizePairs [
	"The 24th special object.
	Smalltalk specialObjectsArray indexOf: Smalltalk specialSelectors"
	^ self specialObjectsArray at: 24 put: anArrayOfSelectorsAndArgumentSizePairs
]

{ #category : 'special objects' }
EPBackend >> symbolTableClass [
	
	^ symbolTableClass ifNil: [
		(self arrayClass instanceVariableAtIndex: self classNameIndex)
			basicClass
			superclass]
]

{ #category : 'special objects' }
EPBackend >> symbolTableClass: aSymbolTableClass [

	symbolTableClass := aSymbolTableClass
]

{ #category : 'special objects' }
EPBackend >> systemDictionary [

	"The Smalltalk instance in most special objects arrays.
	Smalltalk specialObjectsArray indexOf: Smalltalk"
	^ self smalltalkInstance instanceVariableAtIndex: (self instanceVariableMapping smalltalkImageGlobalsIndex).
]

{ #category : 'mirrors' }
EPBackend >> traitMirrorOn: anObject [
	
	^ EPTraitMirror on: anObject from: self
]

{ #category : 'special objects' }
EPBackend >> trueObject [
	"The third special object.
	Smalltalk specialObjectsArray indexOf: true"
	^ self specialObjectsArray at: 3
]

{ #category : 'special objects' }
EPBackend >> trueObject: anEPMirror [ 
	"The third special object.
	Smalltalk specialObjectsArray indexOf: true"
	^ self specialObjectsArray at: 3	put: anEPMirror
]
