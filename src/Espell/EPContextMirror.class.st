"
I am a context mirror object providing basic operations to work on context objects inside an object space. I provide operations to manipulate the stack and the execution of a method, like setting the program counter and temporary variables.
"
Class {
	#name : 'EPContextMirror',
	#superclass : 'EPMirror',
	#category : 'Espell-LowLevel-Mirrors',
	#package : 'Espell',
	#tag : 'LowLevel-Mirrors'
}

{ #category : 'instance creation' }
EPContextMirror class >> createContextForMethod: aRemoteCompiledMethod inObjectSpace: anObjectSpace [
	| contextClassMirror newContext |
	contextClassMirror := anObjectSpace backend contextClass asClassMirror.
	newContext := (contextClassMirror basicNew: aRemoteCompiledMethod frameSize) asContextMirror.
	newContext sender: anObjectSpace nilObject.
	newContext receiver: anObjectSpace nilObject.
	newContext method: aRemoteCompiledMethod.
	newContext closure: anObjectSpace nilObject.
	newContext startpc: aRemoteCompiledMethod initialPC.
	newContext stackPointer: 0.
	newContext initializeTemporaryVariables.
	^newContext
]

{ #category : 'accessing' }
EPContextMirror >> arguments [
	"returns the arguments of a message invocation"
	
	| arguments numargs |
	numargs :=  self method numberOfArguments.
	arguments := Array new: numargs.
	1 to: numargs do: [:i | arguments at: i put: (self tempAt: i) ].
	^ arguments
]

{ #category : 'accessing' }
EPContextMirror >> at: anIndex [
	
	^ self tempAt: anIndex
]

{ #category : 'accessing' }
EPContextMirror >> at: anIndex put: anObject [
	
	^ self tempAt: anIndex put: anObject
]

{ #category : 'accessing' }
EPContextMirror >> basicSize [

	^ backend contextSizeOf: self
]

{ #category : 'accessing' }
EPContextMirror >> closure [
	^self instanceVariableAtIndex: (self backend instanceVariableMapping contextClosureOrNilIndex)
]

{ #category : 'accessing' }
EPContextMirror >> closure: aClosureMirror [
	self instanceVariableAtIndex: (self backend instanceVariableMapping contextClosureOrNilIndex) put: aClosureMirror
]

{ #category : 'accessing' }
EPContextMirror >> frameSize [

	^ self method isNilObject ifTrue: [ CompiledMethod fullFrameSize ] ifFalse: [self method frameSize]
]

{ #category : 'accessing' }
EPContextMirror >> initializeTemporaryVariables [

	"This will push in the context's stack a nil for each of the temporary variables of the method. Both the primitive and the code that follows are in theory doing the same."
	self primitiveInitializeTempsInStack.
	1 to: self method numberOfTemps do: [ :i |
		self tempAt: i put: backend nilObject.
	].
]

{ #category : 'testing' }
EPContextMirror >> isDead [
	^ (self instanceVariableAtIndex: (self backend instanceVariableMapping contextPcIndex)) isNilObject
]

{ #category : 'accessing' }
EPContextMirror >> method [
	^(self instanceVariableAtIndex: (self backend instanceVariableMapping contextMethodIndex)) asMethodMirror
]

{ #category : 'accessing' }
EPContextMirror >> method: aMethodMirror [
	self instanceVariableAtIndex: (self backend instanceVariableMapping contextMethodIndex) put: aMethodMirror
]

{ #category : 'accessing' }
EPContextMirror >> methodReturnContext [
	(self closure pointsToSameObject: backend nilObject)
		ifTrue: [ ^ self ].
	^ self closure outerContext methodReturnContext
]

{ #category : 'initialize - release' }
EPContextMirror >> primitiveInitializeTempsInStack [
	
	backend initializeTempsInStackOfContext: self
]

{ #category : 'accessing' }
EPContextMirror >> receiver [
	^self instanceVariableAtIndex: (self backend instanceVariableMapping contextReceiverIndex)
]

{ #category : 'accessing' }
EPContextMirror >> receiver: aMirror [
	self instanceVariableAtIndex: (self backend instanceVariableMapping contextReceiverIndex) put: aMirror
]

{ #category : 'accessing' }
EPContextMirror >> sender [

	| sender |
	sender := self instanceVariableAtIndex: (self backend instanceVariableMapping contextSenderIndex).
	sender isNilObject ifTrue: [ ^sender ].
	^ sender asContextMirror
]

{ #category : 'accessing' }
EPContextMirror >> sender: aMirror [
	self instanceVariableAtIndex: (self backend instanceVariableMapping contextSenderIndex) put: aMirror
]

{ #category : 'accessing' }
EPContextMirror >> stackPointer [
	^(self instanceVariableAtIndex: (self backend instanceVariableMapping contextStackpIndex)) target
]

{ #category : 'accessing' }
EPContextMirror >> stackPointer: anInteger [
	self instanceVariableAtIndex: (self backend instanceVariableMapping contextStackpIndex) put: (backend smallIntegerMirrorOn: anInteger)
]

{ #category : 'accessing' }
EPContextMirror >> startpc [
	^(self instanceVariableAtIndex: (self backend instanceVariableMapping contextPcIndex)) target
]

{ #category : 'accessing' }
EPContextMirror >> startpc: anInteger [
	self instanceVariableAtIndex: (self backend instanceVariableMapping contextPcIndex) put: (backend smallIntegerMirrorOn: anInteger)
]

{ #category : 'accessing' }
EPContextMirror >> tempAt: anIndex [
	
	^ backend mirrorOn: (self executePrimitive: 210 withArgs: { anIndex })
]

{ #category : 'accessing' }
EPContextMirror >> tempAt: anIndex put: anObjectMirror [
	
	self executePrimitive: 211 withArgs: { anIndex . anObjectMirror target }
]
