"
I am a method mirror object providing basic operations to work on method objects inside an object space.
"
Class {
	#name : 'EPVMCompiledMethodMirror',
	#superclass : 'EPMirror',
	#category : 'Espell-LowLevel-Mirrors',
	#package : 'Espell',
	#tag : 'LowLevel-Mirrors'
}

{ #category : 'instance creation' }
EPVMCompiledMethodMirror class >> createDoit: aString withTemps: aCollection inObjectSpace: anEPObjectSpace [ 
	
	^  anEPObjectSpace crossCompiler compileDoIt: aString
]

{ #category : 'converting' }
EPVMCompiledMethodMirror >> asMethodMirror [

	^ self
]

{ #category : 'accessing' }
EPVMCompiledMethodMirror >> at: anIndex [

	^ backend mirrorOn: (self byteAt: anIndex)
]

{ #category : 'accessing' }
EPVMCompiledMethodMirror >> byteAt: anIndex [
	
	^ (backend object: target at: anIndex) target
]

{ #category : 'accessing' }
EPVMCompiledMethodMirror >> byteAt: anIndex put: aByte [
	
	self at: anIndex put: aByte
]

{ #category : 'accessing' }
EPVMCompiledMethodMirror >> bytecodes [
	^ ByteArray streamContents: [ :s |
		self initialPC to: self endPC do: [:i | 
			s nextPut: (self byteAt: i) ] ].
]

{ #category : 'accessing' }
EPVMCompiledMethodMirror >> bytecodes: someBytecodes [

	| start |
	start := self initialPC - 1.
	someBytecodes withIndexDo: [ :bytecode :index |
		self byteAt: start + index put: (bytecode asLiteralInObjectSpace: self backend).
	]
]

{ #category : 'accessing' }
EPVMCompiledMethodMirror >> endPC [
	^(EPMethodTrailer new method: self) endPC
]

{ #category : 'accessing' }
EPVMCompiledMethodMirror >> frameSize [
	(self header noMask: 16r20000)
		ifTrue: [^ 16 "SmallFrame"]
		ifFalse: [^ 56 "LargeFrame"]
]

{ #category : 'accessing' }
EPVMCompiledMethodMirror >> header [
	^ (self objectAt: 1) target asSmallInteger
]

{ #category : 'accessing' }
EPVMCompiledMethodMirror >> initialPC [
	"Answer the program counter for the receiver's first bytecode."
	^ (self numberOfLiterals + 1) * self backend wordSize + 1
]

{ #category : 'testing' }
EPVMCompiledMethodMirror >> isNamedPrimitive [

	^self primitive = 117
]

{ #category : 'accessing - literals' }
EPVMCompiledMethodMirror >> literalAt: anIndex [

	^ self objectAt: anIndex + 1
]

{ #category : 'accessing - literals' }
EPVMCompiledMethodMirror >> literalAt: anIndex put: aLiteralMirror [

	self
		objectAt: anIndex + 1
		put: aLiteralMirror
]

{ #category : 'accessing - literals' }
EPVMCompiledMethodMirror >> literals [
	^(1 to: self numberOfLiterals) collect: [ :index |
		(self literalAt: index) asLocalLiteral.
	]
]

{ #category : 'accessing - literals' }
EPVMCompiledMethodMirror >> literals: someLiterals [
	someLiterals withIndexDo: [ :literal :index |
		self literalAt: index put: (literal asLiteralInObjectSpace: self objectSpace).
	]
]

{ #category : 'accessing' }
EPVMCompiledMethodMirror >> methodClass [
	| binding |
	binding := self literalAt: self numberOfLiterals.
	binding isNilObject ifTrue: [ ^nil ].
	^(binding instanceVariableAtIndex: 2) asClassMirror
]

{ #category : 'accessing' }
EPVMCompiledMethodMirror >> numberOfArguments [
	"Answer the number of arguments the receiver takes."

	^ (self header bitShift: -24) bitAnd: 16r0F
]

{ #category : 'accessing - literals' }
EPVMCompiledMethodMirror >> numberOfLiterals [
	"Answer the number of literals used by the receiver."
	
	^ backend numberOfLiteralsOf: self target
]

{ #category : 'accessing' }
EPVMCompiledMethodMirror >> numberOfTemps [
	"Answer the number of temporary variables used by the receiver."
	
	^ (self header bitShift: -18) bitAnd: 16r3F
]

{ #category : 'accessing - literals' }
EPVMCompiledMethodMirror >> objectAt: anIndex [
	
	^ backend compiledMethod: self target objectAt: anIndex
]

{ #category : 'accessing - literals' }
EPVMCompiledMethodMirror >> objectAt: anIndex put: anObjectMirror [
	
	backend compiledMethod: self target address objectAt: anIndex put: anObjectMirror target address
]

{ #category : 'accessing - literals' }
EPVMCompiledMethodMirror >> penultimateLiteral [

	| index |
	index := self numberOfLiterals - 1.
	^ index > 0
		ifTrue: [ self literalAt: index ]
		ifFalse: [ self objectSpace nilObject ]
]

{ #category : 'accessing' }
EPVMCompiledMethodMirror >> primitive [
	| primBits |
	primBits := self header bitAnd: 16r100001FF.
	
	^ (primBits bitAnd: 16r1FF) + (primBits bitShift: -19)

]

{ #category : 'accessing - literals' }
EPVMCompiledMethodMirror >> remoteLiterals [
	^(1 to: self numberOfLiterals) collect: [ :index | self literalAt: index]
]

{ #category : 'accessing' }
EPVMCompiledMethodMirror >> selector [
	| penultimateLiteral remoteSelector isSymbol |
	penultimateLiteral := self penultimateLiteral.
	penultimateLiteral isNilObject ifTrue: [ ^nil ].
	
	isSymbol := penultimateLiteral basicClass = backend byteSymbolClass.
	remoteSelector := isSymbol ifTrue: [ penultimateLiteral ]
										ifFalse: [ "It is a method properties object whose second inst var has the selector"
														penultimateLiteral instanceVariableAtIndex: 2 ].
	^ self backend fromRemoteByteSymbol: remoteSelector
]

{ #category : 'accessing' }
EPVMCompiledMethodMirror >> sourceCode [

	^ backend objectSpace sourceCodeManager
		sourceCodeOfMethod: self
		ifAbsent: [ self decompile decompileString ]
]
