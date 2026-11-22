Class {
	#name : 'OptimizedASTInterpreter',
	#superclass : 'ASTInterpreter',
	#category : 'AST-Interpreter-Core-Optimized',
	#package : 'AST-Interpreter-Core',
	#tag : 'Optimized'
}

{ #category : 'testing' }
OptimizedASTInterpreter >> isAccessor: aMethodNode [

	aMethodNode isCompiledMethod ifTrue: [ ^ false ].
	aMethodNode body statements size = 1 ifFalse: [ ^ false ].
	aMethodNode body statements first value isVariable ifFalse: [ 
		^ false ].
	^ aMethodNode body statements first value isInstanceVariable
]

{ #category : 'testing' }
OptimizedASTInterpreter >> isMutator: aMethodNode [

	| assignment |
	aMethodNode isCompiledMethod ifTrue: [ ^ false ].
	aMethodNode body statements size = 1 ifFalse: [ ^ false ].
	aMethodNode body statements first isAssignment ifFalse: [ ^ false ].
	aMethodNode arguments size = 1 ifFalse: [ ^ false ].

	assignment := aMethodNode body statements first.

	assignment variable isInstanceVariable ifFalse: [ ^ false ].
	^ assignment value isArgumentVariable
]

{ #category : 'testing' }
OptimizedASTInterpreter >> optimizedSend: aNode [
	
	"Optimized sends are for block nodes only"
	aNode isBlock ifFalse: [ ^ false ].
	aNode parent isMessage ifFalse: [ ^ false ].
	^ #(#ifTrue:ifFalse: #ifTrue: #ifFalse: #to:do: ifNil: ifNotNil: ifNotNilDo: #ifNil:ifNotNil: whileTrue whileTrue: whileFalse whileFalse )
		includes: aNode parent selector
]

{ #category : 'as yet unclassified' }
OptimizedASTInterpreter >> send: aMessage to: receiver class: class [
	| method replacedMethod |
	
	method := self lookupSelector: aMessage selector in: class.
	method ifNil: [ ^ self sendDoesNotUnderstandFor: aMessage to: receiver ].
	
	replacedMethod := (self tryToReplaceMethod: method) ifNil: [ method ].
	
	^ replacedMethod
		accept: self
		on: receiver
		message: aMessage
]

{ #category : 'as yet unclassified' }
OptimizedASTInterpreter >> send: aMessage to: receiver class: class inNode: aMessageNode [
	| method replacedMethod |
	
	method := aMessageNode polymorphicInlineCache
		at: class
		ifAbsentPut: [ self lookupSelector: aMessage selector in: class. ].
	method ifNil: [ ^ self sendDoesNotUnderstandFor: aMessage to: receiver ].
	
	replacedMethod := (self tryToReplaceMethod: method) ifNil: [ method ].
	
	^ replacedMethod
		accept: self
		on: receiver
		message: aMessage
]

{ #category : 'as yet unclassified' }
OptimizedASTInterpreter >> tryToReplace: aMessageNode [
	
	(aMessageNode selector = #ifTrue:ifFalse:)
		ifTrue: [ ^ OzIfNode replace: aMessageNode ].
	(aMessageNode selector = #ifTrue:)
		ifTrue: [ ^ OzIfTrueNode replace: aMessageNode ].
	(aMessageNode selector = #ifFalse:)
		ifTrue: [ ^ OzIfFalseNode replace: aMessageNode ].
	(aMessageNode selector = #to:do:)
		ifTrue: [ ^ OzToDoNode replace: aMessageNode ].
	(#(ifNil: ifNotNil: ifNotNilDo:)
		includes: aMessageNode selector)
			ifTrue: [ ^ OzIfNilNode replace: aMessageNode ].
	(aMessageNode selector = #ifNil:ifNotNil:)
		ifTrue: [ ^ OzIfNilNode replace: aMessageNode ].
	(#(whileTrue whileTrue: whileFalse whileFalse ) 
		includes: aMessageNode selector)
			ifTrue: [ ^ OzWhileTrueNode replace: aMessageNode ].
	^ nil
]

{ #category : 'as yet unclassified' }
OptimizedASTInterpreter >> tryToReplaceMethod: aMethodNode [
	
	(self isAccessor: aMethodNode)
		ifTrue: [ ^ OzAccessorReadNode replace: aMethodNode ].
	(self isMutator: aMethodNode)
		ifTrue: [ ^ OzAccessorWriteNode replace: aMethodNode ].
	
	^ nil
]

{ #category : 'visiting-special-nodes' }
OptimizedASTInterpreter >> visitAccessorReadMethodNode: aMethodNode [
	
	^ self readInstVarAt: aMethodNode index named: nil
]

{ #category : 'visiting' }
OptimizedASTInterpreter >> visitArgumentNode: aVariableNode [ 
	| definingScope |
	definingScope := aVariableNode binding originalVar definingScope.
	(self optimizedSend: definingScope node) not ifTrue: [ 
		| argIndex |
		argIndex := definingScope node argumentNames indexOf: aVariableNode name.
		^ self readArgumentAt: argIndex node: aVariableNode
	].
	"If it is not an arg, it is a normal temporary"
	^ self readTemporaryAt: -1 named: aVariableNode name
]

{ #category : 'visiting-special-nodes' }
OptimizedASTInterpreter >> visitIfFalseNode: anIfFalseNode [
	| theReceiver block |
	theReceiver := self interpret: anIfFalseNode receiver.
	(self classOf: theReceiver) name = 'False'
		ifTrue: [ block := anIfFalseNode falseCondition body  ]
		ifFalse: [ block := RBLiteralNode value: nil ].
	"It is for sure a block"
	^ self interpret: block.
]

{ #category : 'visiting-special-nodes' }
OptimizedASTInterpreter >> visitIfNilNode: anIfNilNode [
	| theReceiver |
	theReceiver := self interpret: anIfNilNode receiver.
	anIfNilNode trueCondition arguments ifNotEmpty: [
		context temporaries
			at: anIfNilNode trueCondition arguments first name 
			put: theReceiver.
	].

	anIfNilNode trueCondition temporaries do: [ :each | context temporaries
			at: each name 
			put: theReceiver ].

	^ ((self classOf: theReceiver) name = 'UndefinedObject') = anIfNilNode checkForNil
		ifTrue: [ self interpret: anIfNilNode trueCondition body. ]
		ifFalse: [
			anIfNilNode falseCondition isLiteralNode ifTrue: [ ^ theReceiver ].
			anIfNilNode falseCondition parent arguments ifNotEmpty: [
			self context temporaries
				at: anIfNilNode falseCondition parent arguments first name 
				put: theReceiver.
			].
			self interpret: anIfNilNode falseCondition ].

]

{ #category : 'visiting-special-nodes' }
OptimizedASTInterpreter >> visitIfNode: anIfNode [
	| theReceiver block |
	theReceiver := self interpret: anIfNode receiver.
	(self classOf: theReceiver) name = 'True'
		ifTrue: [ block := anIfNode trueCondition ]
		ifFalse: [ block := anIfNode falseCondition ].
	
	^ block isBlock ifTrue: [
		"It is for sure a block"
		self interpret: block body.
	] ifFalse: [ 
		self send: (Message selector: #value) to: (self interpret: block)
	]
]

{ #category : 'visiting-special-nodes' }
OptimizedASTInterpreter >> visitIfTrueNode: anIfTrueNode [
	| theReceiver block |
	theReceiver := self interpret: anIfTrueNode receiver.
	(self classOf: theReceiver) name = 'True'
		ifTrue: [ block := anIfTrueNode trueCondition body ]
		ifFalse: [ block := RBLiteralNode value: nil ].
	"It is for sure a block"
	block isSequence ifTrue: [
		block temporaries do: [ :temp |
			(self context hasTempNamed: temp name) ifFalse: [
				self context temporaries
						at: temp name
						put: (self interpret: (RBLiteralValueNode value: nil)).
			 ]
		]
	].
	^ self interpret: block.
]

{ #category : 'visiting' }
OptimizedASTInterpreter >> visitMessageNode: aMessageNode [

	| replacement |
	replacement := self tryToReplace: aMessageNode.
	replacement ifNotNil: [ ^ replacement acceptVisitor: self ].

	^ super visitMessageNode: aMessageNode
]

{ #category : 'visiting-special-nodes' }
OptimizedASTInterpreter >> visitToDoNode: aToDoNode [

	| from to lastResult |
	from := (aToDoNode fromNode acceptVisitor: self) asSmallInteger.
	to := (aToDoNode toNode acceptVisitor: self) asSmallInteger.
	from to: to do: [ :index |
		self context temporaries
			at: aToDoNode blockNode arguments first name
			put: (self interpret: (RBLiteralNode value:index)).
		aToDoNode blockNode temporaries do: [ :each |
			self context temporaries
				at: each name
				put: context receiver ].
		"It is for sure a block"
		lastResult := self interpret: aToDoNode blockNode body.
		self ifSkip: [ ^ lastResult ] ].

	^ aToDoNode fromNode acceptVisitor: self
]

{ #category : 'visiting-special-nodes' }
OptimizedASTInterpreter >> visitWhileTrueNode: aWhileTrueNode [

	| theReceiver lastResult |
	[ 
	aWhileTrueNode receiver temporaries do: [ :temporary |
		self context temporaries
			at: temporary name
			put: context receiver ].
				
	lastResult := theReceiver := self interpret: aWhileTrueNode receiver body.
	self ifSkip: [ ^ lastResult ].

	(self classOf: theReceiver) name = aWhileTrueNode expectedBooleanValue]
		whileTrue: [
			"It is for sure a block"
"			aWhileTrueNode condition temporaries do: [ :temporary |
				self context temporaries
					at: temporary name
					put: theReceiver ].
"			lastResult := self interpret: aWhileTrueNode condition.
			self ifSkip: [ ^ lastResult ] ].

	^ theReceiver
]
