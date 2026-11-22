"
I interpret AST. I run methods in my method-evalluation protocol, called through acceptMessageNode:receiver:

Instance Variables
	context:		<AIContext>
	currentNode:		<RBProgramNode>
	gotoContext:		<False | AIContext>
	primitiveFailed:		<Boolean>

context
	- is the current context being interpreted

currentNode
	- is the current node being interpreted

gotoContext
	- In the case of non local return or exception it is used to return to the right context after executing the unwinded blocks. 

primitiveFailed
	- primitiveFail token

"
Class {
	#name : 'ASTInterpreter',
	#superclass : 'Object',
	#instVars : [
		'context',
		'gotoContext',
		'currentNode'
	],
	#category : 'AST-Interpreter-Core-Base',
	#package : 'AST-Interpreter-Core',
	#tag : 'Base'
}

{ #category : 'interpreting' }
ASTInterpreter class >> interpretMethod: anASTNode [
	^ self new
		resetContext: AIRootContext new;
		interpretMethod: anASTNode
]

{ #category : 'interpreting' }
ASTInterpreter class >> interpretVMContext: aContext [
	| interpreter |
	self flag: #TODO. "not implemented yet"
	interpreter := self new.
	interpreter resetContext: aContext asASTInterpreterContext.
	^interpreter interpret: aContext sourceNode.
	
]

{ #category : 'deprecated' }
ASTInterpreter >> acceptArgumentNode: aRBArgumentNode [ 
	^ self acceptVariableNode: aRBArgumentNode
]

{ #category : 'deprecated' }
ASTInterpreter >> acceptArrayNode: anArrayNode [
	| array |
	
	array := Array new: anArrayNode statements size.
	anArrayNode statements doWithIndex: [ :statement :i|
		array at: i put: (self interpret: statement)].
	
	self updateGotoContext.
		
	^ array
]

{ #category : 'deprecated' }
ASTInterpreter >> acceptAssignmentNode: anAssignmentNode [
	| value variable |
	
	value := self interpret: anAssignmentNode value.
	variable := anAssignmentNode variable.
	variable binding accept: self assign: value. 
	
	^ value
]

{ #category : 'deprecated' }
ASTInterpreter >> acceptBlockNode: aBlockNode [
	^ ASTBlockClosure new 
		homeContext: self context;
		code: aBlockNode
]

{ #category : 'deprecated' }
ASTInterpreter >> acceptLiteralArrayNode: aNode [
	^ aNode value
]

{ #category : 'deprecated' }
ASTInterpreter >> acceptLiteralNode: aLiteralNode [
	^ aLiteralNode value
	
]

{ #category : 'deprecated' }
ASTInterpreter >> acceptReturnNode: aReturnNode [
	| returnValue |
	
	returnValue := self interpret: aReturnNode value.
	
	self ifSkip: [ ^ returnValue ].
	
	self assert: gotoContext == false.
	gotoContext := context returnContext.
	
	^ returnValue
]

{ #category : 'deprecated' }
ASTInterpreter >> acceptSelfNode: aSelf [
	^ self currentSelf
]

{ #category : 'deprecated' }
ASTInterpreter >> acceptSequenceNode: aSequenceNode [
	| lastResult |
	
	aSequenceNode statements do: [ :statement|
		lastResult := self interpret: statement.
		self ifSkip: [ ^ lastResult ]].
	
	self updateGotoContext.
		
	^ lastResult
]

{ #category : 'deprecated' }
ASTInterpreter >> acceptSuperNode: aSelf [
	^ self currentSelf
]

{ #category : 'deprecated' }
ASTInterpreter >> acceptTemporaryNode: aRBTemporaryNode [ 
	^ self acceptVariableNode: aRBTemporaryNode
]

{ #category : 'deprecated' }
ASTInterpreter >> acceptThisContextNode: thisContextNode [
	^ self context
]

{ #category : 'deprecated' }
ASTInterpreter >> acceptVariableNode: aVariableNode [
	^ aVariableNode binding readWith: self 
]

{ #category : 'reflective' }
ASTInterpreter >> blockClosureEnsure: aBlockClosure message: aMessage [
	| result ensureBlockReturnValue firstGotoContext |
	
	"evaluate the block without arguments"
	result := self blockClosureValue: aBlockClosure. 
	firstGotoContext := gotoContext.
	gotoContext := false.
	
	"evluate the passed in ensure block"
	ensureBlockReturnValue := self blockClosureValue: aMessage arguments first.
	self isExplicitelyReturning
		ifTrue: [ ^ ensureBlockReturnValue ]
		ifFalse: [ gotoContext := firstGotoContext ].
	
	^ result
]

{ #category : 'reflective' }
ASTInterpreter >> blockClosureOnDo: aBlockClosure message: aMessage [
	| block result |
	
	block := aBlockClosure code.
	
	self assert: aMessage numArgs = 2.

	self blockContextFor: aBlockClosure message: aMessage.
	context exceptionHandler: (ExceptionHandler forMessage: aMessage).
	
	result := self interpretBlock: block.
	
	self popContext.
	^ result
]

{ #category : 'reflective' }
ASTInterpreter >> blockClosureValue: aBlockClosure [
	^ self blockClosureValue: aBlockClosure message: (Message selector: #value)
]

{ #category : 'reflective' }
ASTInterpreter >> blockClosureValue: aBlockClosure message: aMessage [
	|newMessage|
	newMessage := Message selector: #valueWithArguments: arguments: (Array with: aMessage arguments).
	^self blockClosureValueWithArguments: aBlockClosure message: newMessage
]

{ #category : 'reflective' }
ASTInterpreter >> blockClosureValueWithArguments: aBlockClosure message: aMessage [
	| block result arguments|
	
	block := aBlockClosure code.
	arguments :=  aMessage arguments at: 1.

	(aBlockClosure numArgs = arguments size) ifFalse: [ ^self reflectiveFailedToken ].
	
	block size = 0 ifTrue: [ ^ nil ].
	
	self blockContextFor: aBlockClosure message: (Message selector: nil arguments: arguments).
	
	result := self interpretBlock: block.

	self isExplicitelyReturning ifTrue: [
		self context homeContext isDead ifTrue: [
			^self sendCannotReturn: result from: context]].
	
	self popContext.
	^ result
]

{ #category : 'context' }
ASTInterpreter >> blockContextFor: aBlockClosure message: aMessage [
	| block |
	
	block := aBlockClosure code.
	
	context := AIBlockContext new
		homeContext: aBlockClosure homeContext;
		outerContext: context;
		closure: aBlockClosure;
		arguments: aMessage arguments;
		temporaries: block temporaryNames.
]

{ #category : 'slots' }
ASTInterpreter >> classOf: anObject [
	^ anObject class
]

{ #category : 'interpretation' }
ASTInterpreter >> compile: aString [
	| ast |
	ast := RBParser parseExpression: aString.
	[ ast methodNode doSemanticAnalysisIn: ProtoObject ]
		on: OCUndeclaredVariableWarning do: [ :e | self error: 'Undeclared variable', e variableNode name ].
	^ ast
]

{ #category : 'accessing' }
ASTInterpreter >> context [
	^ context
]

{ #category : 'accessing' }
ASTInterpreter >> context: aContext [
	context := aContext
]

{ #category : 'reflective' }
ASTInterpreter >> contextTerminateTo: aContext message: aMessage [
	
	gotoContext := aMessage arguments first.
	^ aMessage arguments second
	
]

{ #category : 'accessing' }
ASTInterpreter >> currentMethodClass [
	^ context methodClass
]

{ #category : 'accessing' }
ASTInterpreter >> currentNode [
	^currentNode
]

{ #category : 'accessing' }
ASTInterpreter >> currentSelf [
	^ self context receiver
]

{ #category : 'method evaluation' }
ASTInterpreter >> hasPrimitiveFailed: result [
	"A primitive that fails doesn't always return Context primitiveFailToken but returns Context primitiveFailTokenFor: errorCode.
	A possible errorCode is nil, which corresponds to Context primitiveFailToken.
	Here we loop over the errorCodes to know if the primitive has failed."
	
	|errorCodes|
	
	(self classOf: result) = Context primitiveFailToken class
		ifFalse: [  ^ false ].
		
	errorCodes := SmalltalkImage current specialObjectsArray at: 52.
	errorCodes do: [ :errorCode |
		result = (Context primitiveFailTokenFor: errorCode) ifTrue: [
			^true ] ].
	^false
]

{ #category : 'interpretation' }
ASTInterpreter >> ifSkip: aReturnBlock [
	gotoContext == false ifTrue: [ ^ self ].
	aReturnBlock value.
]

{ #category : 'initialization' }
ASTInterpreter >> initialize [
	super initialize.
	gotoContext := false.
]

{ #category : 'interpretation' }
ASTInterpreter >> interpret: anASTNode [

	currentNode := anASTNode.
	
	^ anASTNode acceptVisitor: self.
]

{ #category : 'interpretation' }
ASTInterpreter >> interpretBlock: block [
	^  self interpret: block body
]

{ #category : 'interpretation' }
ASTInterpreter >> interpretDoIt: ast [
	| result |

	"set the source of the root context to the doIt code"
	self context method: ast source.

	[result := self interpret: ast] 
		on: VariableNotDefined do: [ :e|
		e context isRootContext
			ifFalse: [ e pass ]
			ifTrue: [ e createTemp; resume: true]].

	^ result
]

{ #category : 'interpretation' }
ASTInterpreter >> interpretMethod: method [
	^ self interpret: method body
]

{ #category : 'method evaluation' }
ASTInterpreter >> invokeMethod: aClosure on: receiver message: aMessage [
	| result |

	self assert: aClosure numArgs = aMessage numArgs.
	
	self
		methodContextFor: aClosure
		receiver: receiver
		message: aMessage.

	result := self interpretMethod: aClosure ast.
	
	self isExplicitelyReturning 
		ifFalse: [ result := self currentSelf ].
		
	self popContext.

	^ result
]

{ #category : 'method evaluation' }
ASTInterpreter >> invokePrimitiveMethod: aCompiledMethod on: receiver message: aMessage [
	| result |
	
	result := receiver tryPrimitive: aCompiledMethod primitive withArgs: aMessage arguments.
	(self hasPrimitiveFailed: result)  ifFalse: [ ^ result].
	
	"primitive failed"
	^ self
		invokeMethod: aCompiledMethod 
		on: receiver 
		message: aMessage
]

{ #category : 'method evaluation' }
ASTInterpreter >> invokeReflectiveMethod: aClosure on: receiver message: aMessage [
	| annotation selector result |
	
	annotation := aClosure pragmaAt: #reflective:.
	selector := annotation arguments first.
	
	result := self 
		perform: selector 
		withArguments: (Array with: receiver with: aMessage).
	
	(self classOf: result) = ByteSymbol ifFalse: [ ^result ].
	 result = self reflectiveFailedToken ifFalse: [ ^ result ].

	"primitive failed"
	^self 
		invokeMethod: aClosure 
		on: receiver 
		message: aMessage
]

{ #category : 'testing' }
ASTInterpreter >> isExplicitelyReturning [
	^ gotoContext ~= false
]

{ #category : 'message - sending' }
ASTInterpreter >> lookupSelector: selector in: class [
	| currentClass |
	currentClass := class.
	[ currentClass isNil ] whileFalse: [ 
			currentClass methodDict at: selector ifPresent: [ :method | ^ method ].
			currentClass := currentClass superclass ].
	^ nil
]

{ #category : 'context' }
ASTInterpreter >> methodContextFor: aCompiledMethod receiver: receiver message: aMessage [

	context := AIMethodContext new
					receiver: receiver;
					outerContext: context;
					closure: aCompiledMethod;
					arguments: aMessage arguments;
					temporaries: aCompiledMethod code temporaryNames;
					yourself.
]

{ #category : 'reflective' }
ASTInterpreter >> object: receiver performMessageInSuperclass: aMessage [	
	"Check if the message to perform is valid and if so, execute it"
	
	| selector arguments lookupClass message|
	
	selector := aMessage arguments first.
	arguments := aMessage arguments second.
	lookupClass := aMessage arguments third.

	selector isSymbol
		ifFalse: [^self reflectiveFailedToken].
	selector numArgs = arguments size
		ifFalse: [^self reflectiveFailedToken].
	(receiver isKindOf: lookupClass)
		ifFalse: [^self reflectiveFailedToken].	
			
	message := Message selector: selector arguments: arguments.

	^self send: message to: receiver class: lookupClass
	
]

{ #category : 'reflective' }
ASTInterpreter >> object: receiver performMessageWith: aMessage [	
	"transform the perform:[with:with:with:] methods in perform:withArguments: understood by ast-interpreter"
	
	| arguments oldArgs newMessage|
	oldArgs := aMessage arguments.
	arguments := Array with: oldArgs first with: (Array withAll: (oldArgs copyFrom: 2 to: oldArgs size)).
	newMessage := Message selector: aMessage selector arguments: arguments.
	^ self object: receiver performMessageWithArgs: newMessage	
	
]

{ #category : 'reflective' }
ASTInterpreter >> object: receiver performMessageWithArgs: aMessage [	
	"transform the perform:withArguments: method in perform:withArguments:inSuperclass: understood by ast-interpreter"
	
	| arguments newMessage|
	
	arguments := Array new: 3.
	arguments at: 1 put: aMessage arguments first. "selector"
	arguments at: 2 put: aMessage arguments second. "arguments"
	arguments at: 3 put: (self classOf: receiver). "lookup class"
	
	newMessage := Message selector: aMessage selector arguments: arguments.

	^ self object: receiver performMessageInSuperclass: newMessage	
	
]

{ #category : 'context' }
ASTInterpreter >> popContext [
	context die.
	context := context outerContext.
	
	self updateGotoContext.
]

{ #category : 'slots' }
ASTInterpreter >> readArgumentAt: index named: aName [
	^ self context arguments at: index
]

{ #category : 'slots' }
ASTInterpreter >> readArgumentAt: index node: aVariableNode [
	
	^ self context variableNamed: aVariableNode name
]

{ #category : 'slots' }
ASTInterpreter >> readArgumentNamed: aName [
	^ self context tempNamed: aName
]

{ #category : 'slots' }
ASTInterpreter >> readInstVarAt: index named: name [
	^ self currentSelf instVarAt: index
]

{ #category : 'slots' }
ASTInterpreter >> readTemporaryAt: index named: name [
	^ context variableNamed: name
]

{ #category : 'interpretation' }
ASTInterpreter >> reflectiveFailedToken [
	^#primitiveFailedASTInterpreterToken
]

{ #category : 'accessing' }
ASTInterpreter >> resetContext: aContext [
	context := aContext.
	gotoContext :=  false.
]

{ #category : 'reflective' }
ASTInterpreter >> rootContextHandleSignal: aRootContext  message: aMessage [
	| exception |
	
	exception := aMessage arguments first.
	
	exception class = Halt
		ifTrue: [ ^ InterpretationError signalFor: exception ].
		
	"run the normal excpetion handling procedures if there is no Halt"
	self 
		invokeMethod: (AIRootContext >> #handleSignal:) 
		on: aRootContext 
		message: aMessage
]

{ #category : 'message - sending' }
ASTInterpreter >> send: aMessage to: receiver [
	^ self
		send: aMessage
		to: receiver
		class: (self classOf: receiver)
]

{ #category : 'message - sending' }
ASTInterpreter >> send: aMessage to: receiver class: class [
	| method |
	
	method := self lookupSelector: aMessage selector in: class.
	method ifNil: [ ^ self sendDoesNotUnderstandFor: aMessage to: receiver ].
	
	^ method
		accept: self
		on: receiver
		message: aMessage
]

{ #category : 'message - sending' }
ASTInterpreter >> send: aMessage to: receiver class: class inNode: aNode [
	| method |
	
	method := self lookupSelector: aMessage selector in: class.
	method ifNil: [ ^ self sendDoesNotUnderstandFor: aMessage to: receiver ].
	
	^ method
		accept: self
		on: receiver
		message: aMessage
]

{ #category : 'message - sending' }
ASTInterpreter >> sendCannotReturn: result from: returnContext [
	| cannotReturn |
	gotoContext := false.
	self popContext.
	cannotReturn := Message selector: #cannotReturn: argument: result.
	^ self send: cannotReturn to: returnContext
]

{ #category : 'message - sending' }
ASTInterpreter >> sendDoesNotUnderstandFor: aMessage to: receiver [
	| dnu |
	dnu := Message selector: #doesNotUnderstand: argument: aMessage.
	^ self send: dnu to: receiver
]

{ #category : 'reflective' }
ASTInterpreter >> unhandledErrorDefaultAction: anUnhandledError  message: aMessage [

	^ InterpretationError signalFor: anUnhandledError exception.
]

{ #category : 'visiting' }
ASTInterpreter >> updateGotoContext [

	gotoContext == context
		ifTrue: [ gotoContext := false ].
]

{ #category : 'visiting' }
ASTInterpreter >> visitArgumentNode: aRBArgumentNode [ 
	^ self visitVariableNode: aRBArgumentNode
]

{ #category : 'visiting' }
ASTInterpreter >> visitArgumentVariableNode: aRBVariableNode [ 
	
	^ self visitVariableNode: aRBVariableNode
]

{ #category : 'visiting' }
ASTInterpreter >> visitArrayNode: anArrayNode [
	| array |
	
	array := Array new: anArrayNode statements size.
	anArrayNode statements doWithIndex: [ :statement :i|
		array at: i put: (self interpret: statement)].
	
	self updateGotoContext.
		
	^ array
]

{ #category : 'visiting' }
ASTInterpreter >> visitAssignmentNode: anAssignmentNode [
	| value variable |
	
	value := self interpret: anAssignmentNode value.
	variable := anAssignmentNode variable.
	variable binding accept: self assign: value inNode: variable.
	
	^ value
]

{ #category : 'visiting' }
ASTInterpreter >> visitBlockNode: aBlockNode [
	^ ASTBlockClosure new
		homeContext: self context;
		code: aBlockNode
]

{ #category : 'visiting' }
ASTInterpreter >> visitCascadeNode: aCascadeNode [
	| receiver lastResult |
	
	receiver := self interpret: aCascadeNode receiver.
	
	aCascadeNode messages do: [ :aMessageNode|
		lastResult := self visitMessageNode: aMessageNode receiver: receiver.
		self ifSkip: [ ^ lastResult ]].
	
	^ lastResult
]

{ #category : 'visiting' }
ASTInterpreter >> visitClassVariableNode: aRBVariableNode [ 

	^ self visitGlobalVariableNode: aRBVariableNode
]

{ #category : 'visiting' }
ASTInterpreter >> visitLiteralArrayNode: aNode [
	^ aNode value
]

{ #category : 'visiting' }
ASTInterpreter >> visitLiteralNode: aLiteralNode [
	^ aLiteralNode value
	
]

{ #category : 'visiting' }
ASTInterpreter >> visitLiteralValueNode: aLiteralNode [

	^ self visitLiteralNode: aLiteralNode
	
]

{ #category : 'visiting' }
ASTInterpreter >> visitMessageNode: aMessageNode [
	| receiver |

	receiver := self interpret: aMessageNode receiver.
	
	self ifSkip: [^receiver ].
	
	^ self visitMessageNode: aMessageNode receiver: receiver.
]

{ #category : 'visiting' }
ASTInterpreter >> visitMessageNode: aMessageNode receiver: receiver [
	| arguments message lookUpClass|
	
	context currentExecutedNode: aMessageNode.
	
	arguments := (aMessageNode arguments 
						collect: [ :argument| |arg|
							arg := (self interpret: argument).
							self ifSkip: [ ^ arg ].
							arg ]) asArray.
						
	message := Message selector: aMessageNode selector arguments: arguments.
	
	lookUpClass := aMessageNode isSuperSend 
						ifFalse: [ self classOf: receiver ]
						ifTrue: [ self currentMethodClass superclass ].
	
	^ self
		send: message
		to: receiver
		class: lookUpClass
		inNode: aMessageNode
]

{ #category : 'visiting' }
ASTInterpreter >> visitReturnNode: aReturnNode [
	| returnValue |
	
	returnValue := self interpret: aReturnNode value.
	
	self ifSkip: [ ^ returnValue ].
	
	self assert: gotoContext == false.
	gotoContext := context returnContext.
	
	^ returnValue
]

{ #category : 'visiting' }
ASTInterpreter >> visitSelfNode: aSelf [
	^ self currentSelf
]

{ #category : 'visiting' }
ASTInterpreter >> visitSequenceNode: aSequenceNode [
	| lastResult |
	
	aSequenceNode statements do: [ :statement|
		lastResult := self interpret: statement.
		self ifSkip: [ ^ lastResult ]].
	
	self updateGotoContext.
		
	^ lastResult
]

{ #category : 'visiting' }
ASTInterpreter >> visitSuperNode: aSelf [
	^ self currentSelf
]

{ #category : 'visiting' }
ASTInterpreter >> visitTemporaryNode: aRBTemporaryNode [ 
	^ self visitVariableNode: aRBTemporaryNode
]

{ #category : 'visiting' }
ASTInterpreter >> visitTemporaryVariableNode: aRBVariableNode [ 
	
	^ self visitTemporaryNode: aRBVariableNode
]

{ #category : 'visiting' }
ASTInterpreter >> visitThisContextNode: thisContextNode [
	^ self context
]

{ #category : 'visiting' }
ASTInterpreter >> visitVariableNode: aVariableNode [
	^ aVariableNode binding readWith: self inNode: aVariableNode
]

{ #category : 'slots' }
ASTInterpreter >> write: aValue at: index named: name [
	^ self currentSelf instVarAt: index put: aValue
]

{ #category : 'slots' }
ASTInterpreter >> write: aValue temporaryAt: index named: name [
	^ context tempNamed: name put: aValue
]
