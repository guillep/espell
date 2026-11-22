Class {
	#name : 'EPASTInterpreter',
	#superclass : 'OptimizedASTInterpreter',
	#instVars : [
		'evaluator',
		'astCache'
	],
	#category : 'Espell-HighLevel',
	#package : 'Espell',
	#tag : 'HighLevel'
}

{ #category : 'initialize-release' }
EPASTInterpreter >> astCache: aCache [
	astCache := aCache
]

{ #category : 'reflective' }
EPASTInterpreter >> blockClosureEnsure: aBlockClosure message: aMessage [
	
	^ super blockClosureEnsure: aBlockClosure target target message: aMessage
]

{ #category : 'reflective' }
EPASTInterpreter >> blockClosureOnDo: aBlockClosure message: aMessage [
	
	^ super blockClosureOnDo: (self unwrapBlockClosure: aBlockClosure) message: aMessage
]

{ #category : 'reflective' }
EPASTInterpreter >> blockClosureValue: aBlockClosure message: aMessage [
	
	^ super blockClosureValue: aBlockClosure target message: aMessage
]

{ #category : 'reflective' }
EPASTInterpreter >> blockClosureValueWithArguments: aBlockClosure message: aMessage [
	
	^ super blockClosureValueWithArguments: (self unwrapBlockClosure: aBlockClosure) message: aMessage
]

{ #category : 'private' }
EPASTInterpreter >> classOf: anObject [

	^evaluator classOf: anObject
]

{ #category : 'method evaluation' }
EPASTInterpreter >> closureAST: aClosure forReceiver: aReceiver [
	| astToBind compilationContext |
	
	astCache at: aClosure ifPresent: [ :ast | ^ ast ].
	
	astToBind := aClosure parseTree copyInContext: Dictionary new.
	compilationContext := self class compiler compilationContext.
	compilationContext class: (PBClassDefinition on: aClosure methodClass environment: evaluator environment).
	compilationContext environment: self environment.
	
	^ astCache at: aClosure put: (astToBind
		compilationContext: compilationContext;
		doSemanticAnalysis).
]

{ #category : 'accessing' }
EPASTInterpreter >> environment [
	
	^ evaluator environment
]

{ #category : 'interpretation' }
EPASTInterpreter >> evaluateAST: someAST [
	self 
		methodContextFor: someAST methodNode
		receiver: evaluator objectSpace nilObject
		message: (Message selector: #DoIt arguments: #()).
	gotoContext :=  false.
	
	^self interpret: someAST
]

{ #category : 'interpretation' }
EPASTInterpreter >> evaluateCode: someCode [
	^self evaluateAST: (self compile: someCode)
]

{ #category : 'method evaluation' }
EPASTInterpreter >> hasPrimitiveFailed: result [
	"A primitive that fails doesn't always return ContextPart primitiveFailToken but returns ContextPart primitiveFailTokenFor: errorCode.
	A possible errorCode is nil, which corresponds to ContextPart primitiveFailToken.
	Here we loop over the errorCodes to know if the primitive has failed."
	
	^evaluator objectSpace backend hasPrimitiveFailed: result
]

{ #category : 'initialize-release' }
EPASTInterpreter >> initialize [
	super initialize.
	astCache := IdentityDictionary new.
]

{ #category : 'initialize-release' }
EPASTInterpreter >> initializeAstOfBehaviorDefinition: definition fromBehavior: mirror [
	definition methods do: [ :methodDefinition | 
		self
			initializeAstOfMethodDefinition: methodDefinition
			fromBehavior: mirror.
	].
]

{ #category : 'initialize-release' }
EPASTInterpreter >> initializeAstOfMethodDefinition: definition fromBehavior: mirror [
	ASTCache
		at: definition
		put: (definition generateASTBindedTo: mirror inObjectSpace: evaluator objectSpace)
]

{ #category : 'initialize-release' }
EPASTInterpreter >> initializeWithEvaluator: anEvaluator [

	evaluator := anEvaluator
]

{ #category : 'method evaluation' }
EPASTInterpreter >> invokeMethod: aClosure on: receiver message: aMessage [
	| result |

	self assert: aClosure numArgs = aMessage numArgs.
	
	self
		methodContextFor: aClosure
		receiver: receiver
		message: aMessage.

	result := self interpretMethod: (self closureAST: aClosure forReceiver: receiver ).
	
	self isExplicitelyReturning 
		ifFalse: [ result := self currentSelf ].
		
	self popContext.

	^ result
]

{ #category : 'method evaluation' }
EPASTInterpreter >> invokePrimitiveMethod: aMethod on: receiver message: aMessage [
	| result |
	
	self flag: 'TODO: should track the tower of interpreters properly...'.
	
	aMethod isCompiledMethod ifTrue: [ 
		^ receiver backend mirrorOnExternalHandle: (aMethod
			valueWithReceiver: receiver target object
			arguments: aMessage arguments)
	].
	
	result := receiver executePrimitiveMethod: aMethod withArguments: aMessage arguments.
	result hasFailed ifFalse: [ 
		^ result value ].
	
	"primitive failed"
	^ self
		invokeMethod: aMethod 
		on: receiver 
		message: aMessage
]

{ #category : 'method evaluation' }
EPASTInterpreter >> invokeReflectiveMethod: aClosure on: receiver message: aMessage [
	| annotation selector result |
	
	annotation := aClosure pragmaAt: #reflective:.
	selector := annotation arguments first value.
	
	result := self 
		perform: selector 
		withArguments: (Array with: receiver with: aMessage).
	
	 ByteSymbol == result basicClass target ifFalse: [ ^result ].
	 result = self reflectiveFailedToken ifFalse: [ ^ result ].

	"primitive failed"
	^self 
		invokeMethod: aClosure 
		on: receiver 
		message: aMessage
]

{ #category : 'private' }
EPASTInterpreter >> loadClass: aGlobalVariable [

	"^ aGlobalVariable binding assoc bindingContext sourceEnvironment classNamed: aGlobalVariable name"
	^ evaluator environment createBehaviorFromDefinition: (evaluator environment definitionNamed: aGlobalVariable name)
]

{ #category : 'lookup' }
EPASTInterpreter >> lookupFrom: aRFiClass until: aBlockClosure ifNone: aBlockClosure3 [ 
	
	| lookupClass |
	lookupClass := aRFiClass.
	[lookupClass isNil] whileFalse: [ 
		(aBlockClosure value: lookupClass) ifTrue: [ ^ lookupClass ].
		lookupClass := lookupClass superclass ].
	aBlockClosure3 value.
]

{ #category : 'private' }
EPASTInterpreter >> lookupSelector: selector in: class [
	| found |
	"This I think could be safe to remove"
	class = ASTBlockClosure
		ifTrue: [ ^super lookupSelector: selector in: class ].
	
	found := self
		lookupFrom: class
		until: [ :c | c includesSelector: selector ]
		ifNone: [ self error: selector, ' not found in ' , class name ].
	^ (found methods detect: [ :m | m selector = selector ]) ast
]

{ #category : 'private' }
EPASTInterpreter >> mappingOf: anObject [

	^evaluator mappingOf: anObject
]

{ #category : 'context' }
EPASTInterpreter >> methodContextFor: aCompiledMethod receiver: receiver message: aMessage [
	super methodContextFor: aCompiledMethod receiver: receiver message: aMessage.
	context temporaries keysDo: [ :k | context temporaries at: k put: evaluator objectSpace nilObject ]
]

{ #category : 'visiting' }
EPASTInterpreter >> newClassLoaderVisitor [

	^ EPASTClassLoaderVisitor new
		interpreter: self;
		yourself
]

{ #category : 'reflective' }
EPASTInterpreter >> object: receiver performMessageInSuperclass: aMessage [	
	"Check if the message to perform is valid and if so, execute it"
	
	| selector arguments lookupClass message|
	
	selector := aMessage arguments first.
	arguments := aMessage arguments second.
	lookupClass := aMessage arguments third.
			
	message := Message selector: selector asLocalLiteral arguments: arguments.

	^self send: message to: receiver class: lookupClass
]

{ #category : 'accessing' }
EPASTInterpreter >> objectSpace [
	
	^ evaluator objectSpace
]

{ #category : 'slots' }
EPASTInterpreter >> readInstVarAt: index named: name [
	^ self currentSelf instanceVariableAtIndex: index
]

{ #category : 'private' }
EPASTInterpreter >> unwrapBlockClosure: maybeBlock [
	
	^ maybeBlock target object
	"| block |
	block := maybeBlock.
	[block isKindOf: ASTBlockClosure]
		whileFalse: [ block := maybeBlock target ].
	^ block"
]

{ #category : 'visiting' }
EPASTInterpreter >> visitArrayNode: anArrayNode [
	
	^ evaluator objectSpace newArrayWithAll: (super acceptArrayNode: anArrayNode)
]

{ #category : 'visiting' }
EPASTInterpreter >> visitBlockNode: aBlockNode [
	^ evaluator objectSpace backend mirrorOnExternalHandle: (super visitBlockNode: aBlockNode)
]

{ #category : 'visiting' }
EPASTInterpreter >> visitClassDefinition: anOzClassDefinition [ 
	
	anOzClassDefinition superclass acceptVisitor: self newClassLoaderVisitor.
	anOzClassDefinition sharedPools do: [ :class | class acceptVisitor: self newClassLoaderVisitor ].
	anOzClassDefinition hasTraitComposition ifTrue: [ anOzClassDefinition traitComposition acceptVisitor: self newClassLoaderVisitor ].
	^ anOzClassDefinition message acceptVisitor: self.
]

{ #category : 'visiting' }
EPASTInterpreter >> visitGlobalVariableNode: aVariableNode [
	
	^ aVariableNode binding readWith: self inNode: aVariableNode
]

{ #category : 'visiting' }
EPASTInterpreter >> visitInstanceVariableNode: aRBInstanceVariableNode [ 
	
	^ aRBInstanceVariableNode binding readWith: self inNode: aRBInstanceVariableNode
]

{ #category : 'visiting' }
EPASTInterpreter >> visitLiteralArrayNode: aNode [
	^ self visitLiteralNode: aNode
]

{ #category : 'visiting' }
EPASTInterpreter >> visitLiteralNode: aLiteralNode [
	^aLiteralNode value asLiteralInObjectSpace: evaluator objectSpace
]

{ #category : 'visiting' }
EPASTInterpreter >> visitMessageNode: aMessageNode [
	
	| replacement receiver |

	replacement := self tryToReplace: aMessageNode.
	replacement ifNotNil: [ ^ replacement acceptVisitor: self ].
	
	receiver := self interpret: aMessageNode receiver.

	self ifSkip: [^receiver ].
	
	^ self visitMessageNode: aMessageNode receiver: receiver.
]

{ #category : 'visiting' }
EPASTInterpreter >> visitSequenceNode: aSequenceNode [
	| lastResult |
	lastResult := evaluator objectSpace nilObject.
	aSequenceNode statements do: [ :statement|
		lastResult := self interpret: statement.
		self ifSkip: [ ^ lastResult ]].
	
	self updateGotoContext.
		
	^ lastResult
]

{ #category : 'visiting' }
EPASTInterpreter >> visitThisContextNode: thisContextNode [
	self halt.
	^ super visitThisContextNode: thisContextNode
]

{ #category : 'visiting' }
EPASTInterpreter >> visitTraitDefinition: anOzClassDefinition [ 
	
	"anOzClassDefinition message receiver acceptVisitor: self newClassLoaderVisitor."
	anOzClassDefinition hasTraitComposition ifTrue: [ anOzClassDefinition traitComposition acceptVisitor: self newClassLoaderVisitor ].
	^ anOzClassDefinition message acceptVisitor: self.
]

{ #category : 'visiting' }
EPASTInterpreter >> visitVariableNode: aVariableNode [

	| theBinding |
	theBinding := aVariableNode binding isLiteralVariable
		ifTrue: [ aVariableNode binding assoc ]
		ifFalse: [ aVariableNode binding ].
	^ theBinding readWith: self inNode: aVariableNode
]

{ #category : 'slots' }
EPASTInterpreter >> write: aValue at: index named: name [
	^ self currentSelf instanceVariableAtIndex: index put: aValue
]
