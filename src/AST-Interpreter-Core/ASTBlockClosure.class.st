"
I am a specific class to the ASTInterpreter. I represent a BlockClosure in Pharo.

Instance Variables
	homeContext:		<AIContext>

homeContext
	- is the homeContext of the BlockClosure
	 <is duplicated with ASTBlockClosure - homeContext>

"
Class {
	#name : 'ASTBlockClosure',
	#superclass : 'BlockClosure',
	#type : 'variable',
	#instVars : [
		'homeContext',
		'code'
	],
	#category : 'AST-Interpreter-Core-Base',
	#package : 'AST-Interpreter-Core',
	#tag : 'Base'
}

{ #category : 'testing' }
ASTBlockClosure >> = anASTBlockClosure [
	(anASTBlockClosure class == self class)ifFalse: [^false].
	(self homeContext = anASTBlockClosure homeContext)ifFalse: [^false].
	^true
]

{ #category : 'visiting' }
ASTBlockClosure >> accept: visitor [
	^ visitor visitBlockClosure: self
]

{ #category : 'accessing' }
ASTBlockClosure >> code [

	^ code
]

{ #category : 'accessing' }
ASTBlockClosure >> code: anObject [
	
	code := anObject
]

{ #category : 'evaluating' }
ASTBlockClosure >> cull: anArg [
	^ self numArgs = 0 
		ifTrue: [self value]
		ifFalse: [self value: anArg]
	
]

{ #category : 'evaluating' }
ASTBlockClosure >> cull: firstArg cull: secondArg [
	^ self numArgs < 2 
		ifTrue: [self cull: firstArg]
		ifFalse: [self value: firstArg value: secondArg]
	
]

{ #category : 'evaluating' }
ASTBlockClosure >> cull: firstArg cull: secondArg cull: thirdArg [
	^ self numArgs < 3 
		ifTrue: [self cull: firstArg cull: secondArg]
		ifFalse: [self value: firstArg value: secondArg value: thirdArg]
	
]

{ #category : 'evaluating' }
ASTBlockClosure >> cull: firstArg cull: secondArg cull: thirdArg cull: fourthArg [
	"Execute the receiver with four or less arguments. Check cull:cull: for examples"
	
	^ self numArgs < 4 
		ifTrue: [self cull: firstArg cull: secondArg cull: thirdArg]
		ifFalse: [self value: firstArg value: secondArg value: thirdArg value: fourthArg]
	
]

{ #category : 'exception' }
ASTBlockClosure >> ensure: aBlock [
	"Evaluate a termination block after evaluating the receiver, regardless of
	 whether the receiver's evaluation completes."
	
	<reflective: #blockClosureEnsure:message:>
	PrimitiveFailed signal
]

{ #category : 'accessing' }
ASTBlockClosure >> homeContext [

	^ homeContext
]

{ #category : 'accessing' }
ASTBlockClosure >> homeContext: aContext [

	homeContext := aContext
]

{ #category : 'accessing' }
ASTBlockClosure >> numArgs [
	^ self code arguments size
]

{ #category : 'exception' }
ASTBlockClosure >> on: exception do: aBlock [
	<reflective: #blockClosureOnDo:message:>
	PrimitiveFailed signal
]

{ #category : 'printing' }
ASTBlockClosure >> printOn: aStream [	
	aStream nextPutAll: 'ASTBlockClosure: '.
	aStream nextPutAll: self code formattedCode
]

{ #category : 'accessing' }
ASTBlockClosure >> returnContext [

	^ homeContext returnContext
]

{ #category : 'evaluating' }
ASTBlockClosure >> value [
	<reflective: #blockClosureValue:message:>
	^ self valueWithArguments: (Array new: 0)
]

{ #category : 'evaluating' }
ASTBlockClosure >> value: anArg [
	<reflective: #blockClosureValue:message:>
	^ self valueWithArguments: (Array with: anArg)
]

{ #category : 'evaluating' }
ASTBlockClosure >> value: anArg value: otherArg [
	<reflective: #blockClosureValue:message:>
	^ self valueWithArguments: (Array with: anArg with: otherArg)
]

{ #category : 'evaluating' }
ASTBlockClosure >> value: anArg value: otherArg value: anotherArg [
	<reflective: #blockClosureValue:message:>
	^ self valueWithArguments: (Array with: anArg with: otherArg with: anotherArg)
]

{ #category : 'evaluating' }
ASTBlockClosure >> value: anArg value: otherArg value: anotherArg value: yetAnotherArg [
	<reflective: #blockClosureValue:message:>
	^ self valueWithArguments: (Array with: anArg with: otherArg with: anotherArg with: yetAnotherArg)
]

{ #category : 'exception' }
ASTBlockClosure >> valueNoContextSwitch [
	^ self value
]

{ #category : 'evaluating' }
ASTBlockClosure >> valueWithArguments: anArray [
	| newContext ncv |
	<reflective: #blockClosureValueWithArguments:message:>
	self numArgs ~= anArray size ifTrue:
		[self numArgsError: anArray size].
	^PrimitiveFailed signal
]

{ #category : 'evaluating' }
ASTBlockClosure >> valueWithPossibleArgs: anArray [
	| numberOfArgs |
	numberOfArgs := self numArgs.
	numberOfArgs = 0
		ifTrue: [ ^ self value ].
	numberOfArgs = anArray size
		ifTrue: [ ^ self valueWithArguments: anArray ].
	numberOfArgs > anArray size
		ifTrue: [ ^ self valueWithArguments: anArray , (Array new: numberOfArgs - anArray size) ].
	^ self valueWithArguments: (anArray copyFrom: 1 to: numberOfArgs)
]
