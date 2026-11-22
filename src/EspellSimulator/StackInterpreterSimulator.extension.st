Extension { #name : 'StackInterpreterSimulator' }

{ #category : '*EspellSimulator' }
StackInterpreterSimulator >> checkStackIntegrity [
	
	^ true
]

{ #category : '*EspellSimulator' }
StackInterpreterSimulator >> framePointer: theFP [
	"Simulation only"
	<doNotGenerate>
	framePointer := theFP
]

{ #category : '*EspellSimulator' }
StackInterpreterSimulator >> instructionPointer: aValue [
	<doNotGenerate>
	instructionPointer := aValue
]

{ #category : '*EspellSimulator' }
StackInterpreterSimulator >> primitiveFunctionPointer: oop [
	"Apparently not sent but is used in the simulator."
	<doNotGenerate>
	primitiveFunctionPointer := oop
]

{ #category : '*EspellSimulator' }
StackInterpreterSimulator >> setMethodUnchecked: aMethodObj [
	"Set the method and determine the bytecode set based on the method header's sign.
	 If MULTIPLEBYTECODESETS then a negative header selects the alternate bytecode set.
	 Conditionalizing the code on MULTIPLEBYTECODESETS allows the header sign bit to be
	 used for other experiments."
	<inline: true>
	method := aMethodObj.
	self cppIf: MULTIPLEBYTECODESETS
		ifTrue: [bytecodeSetSelector := (self methodUsesAlternateBytecodeSet: method)
											ifTrue: [256]
											ifFalse: [0]]
]

{ #category : '*EspellSimulator' }
StackInterpreterSimulator >> stackPointer [
	^stackPointer
]

{ #category : '*EspellSimulator' }
StackInterpreterSimulator >> stackPointer: theSP [
	"Simulation only"
	<doNotGenerate>
	stackPointer := theSP
]

{ #category : '*EspellSimulator' }
StackInterpreterSimulator >> thisClassIndex: anIndex [
	<doNotGenerate>
	thisClassIndex := anIndex
]
