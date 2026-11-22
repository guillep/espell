"
I am an abstract specific context for the ASTInterpreter that represents Context in Pharo.

Instance Variables
	arguments:		<Collection>
	closure:		<CompiledMethod | ASTBlockClosure>
	isExecuted:		<Boolean>
	outerContext:		<AIContext>
	temporaries:		<Dictionary>

arguments
	- is the collection of the arguments of the method

closure
	- is either a CompiledMethod or an ASTBlockClosure, depending if I am an AIBlockClosure or an AIMethodContext

isExecuted
	- permits to know if my method has already been executed. In Pharo, when I am terminated my pc is set to nil. Then, you can know if I am terminated by checking if my pc is nil. In the ASTInterpreter we don't have pc so we use isExecuted boolean to know if the context is terminated. (isExecuted make the test ASTInterpreterTest>>testNonLocalReturnPart2 pass with the returningBlock)

outerContext
	- is my sender

temporaries
	- is the collection of the arguments + the temporaries of the method

"
Class {
	#name : 'AIContext',
	#superclass : 'Object',
	#instVars : [
		'closure',
		'temporaries',
		'arguments',
		'outerContext',
		'currentExecutedNode'
	],
	#category : 'AST-Interpreter-Core-Base',
	#package : 'AST-Interpreter-Core',
	#tag : 'Base'
}

{ #category : 'testing' }
AIContext >> = anAIContext [
	(anAIContext class == self class)ifFalse: [^false].
	(self closure = anAIContext closure)ifFalse: [^false].
	(self temporaries = anAIContext temporaries)ifFalse: [^false].
	(self arguments = anAIContext arguments)ifFalse: [^false].
	(self outerContext = anAIContext outerContext)ifFalse:[^false].
	^true
	
]

{ #category : 'accessing' }
AIContext >> argumentNamed: aName [
	
	| index |
	index := self code argumentNames indexOf: aName.
	
	index = 0 ifFalse: [ ^ self arguments at: index ].
	
	^ self tempNamed: aName
]

{ #category : 'accessing' }
AIContext >> arguments [
	^ arguments
]

{ #category : 'accessing' }
AIContext >> arguments: aCollection [
	arguments := aCollection
]

{ #category : 'exception-handling' }
AIContext >> cannotReturn: result [

	closure notNil ifTrue:
		[^self cannotReturn: result to: self home sender].
	Smalltalk tools debugger
						openContext: thisContext
						label: 'computation has been terminated'
						contents: nil
]

{ #category : 'exception-handling' }
AIContext >> cannotReturn: result to: homeContext [
	"The receiver tried to return result to homeContext that no longer exists."

	^ BlockCannotReturn new
		result: result;
		deadHome: homeContext;
		signal
]

{ #category : 'accessing' }
AIContext >> closure [

	^ closure
]

{ #category : 'accessing' }
AIContext >> closure: anObject [
	
	closure := anObject
]

{ #category : 'accessing' }
AIContext >> code [
	^ self closure code
]

{ #category : 'compatibility layer' }
AIContext >> contextTag [
	^ self
]

{ #category : 'accessing' }
AIContext >> createTemp: aName [
	self temporaries at: aName put: nil.
]

{ #category : 'accessing' }
AIContext >> currentExecutedNode [
	^ currentExecutedNode
]

{ #category : 'accessing' }
AIContext >> currentExecutedNode: anObject [
	currentExecutedNode := anObject
]

{ #category : 'debugging' }
AIContext >> debugPrintString [
	self subclassResponsibility 
]

{ #category : 'continuation' }
AIContext >> die [
	currentExecutedNode := nil
]

{ #category : 'exception-handling' }
AIContext >> findContextSuchThat: testBlock [
	"Search self and my sender chain for first one that satisfies testBlock.  Return nil if none satisfy"

	| ctxt |
	
	ctxt := self.
	[ctxt isNil] whileFalse: [
		(testBlock value: ctxt) 
			ifTrue: [^ ctxt].
		ctxt := ctxt outerContext ].

	^ nil
]

{ #category : 'exception-handling' }
AIContext >> findNextHandlerContext [
	"Return the next handler marked context, returning nil if there is none.  
	Search starts with self and proceeds up to nil."
	
	^ self findContextSuchThat: [ :ctxt| ctxt hasExceptionHandler ]
]

{ #category : 'exception-handling' }
AIContext >> handleSignal: exception [
	"Sent to handler (on:do:) contexts only.  If my exception class (first arg) handles exception then execute my handle block (second arg), otherwise forward this message to the next handler context.  If none left, execute exception's defaultAction (see nil>>handleSignal:)."

	| result |
	
	(self exceptionHandler handles: exception)
		ifFalse: [ ^ self nextHandlerContext handleSignal: exception].

	exception privHandlerContext: self contextTag.
	
	"self tempAt: 3 put: false. " "disable self while executing handle block"
	
	result := self exceptionHandler handle: exception.
	
	self return: result.  "return from self if not otherwise directed in handle block"

]

{ #category : 'testing' }
AIContext >> hasExceptionHandler [
	^ false
]

{ #category : 'accessing' }
AIContext >> hasTempNamed: aName [
	self temporaries 
		at: aName 
		ifPresent: [ :value| ^ true ].
	
	self homeContext 
		ifNil: [ ^ false ].
		
	^ self homeContext hasTempNamed: aName.
]

{ #category : 'compatibility layer' }
AIContext >> home [
	^ self homeContext
]

{ #category : 'accessing' }
AIContext >> homeContext [
	self subclassResponsibility
]

{ #category : 'initialization' }
AIContext >> initialize [
	self flag: 'for now the easies solution'.
]

{ #category : 'initialize-release' }
AIContext >> initializeContext: aContext [ 
	self outerContext: aContext outerContext asASTInterpreterContext.
	self arguments: aContext arguments.
	aContext tempNames do: [:tempName |
		self temporaries at: tempName put: (aContext tempNamed: tempName)]
]

{ #category : 'testing' }
AIContext >> isDead [
	^currentExecutedNode isNil
]

{ #category : 'testing' }
AIContext >> isRootContext [
	^false
]

{ #category : 'accessing' }
AIContext >> methodClass [
	^ closure methodClass
]

{ #category : 'accessing' }
AIContext >> methodNode [
    ^ currentExecutedNode methodNode
]

{ #category : 'exception-handling' }
AIContext >> nextHandlerContext [

	^ self outerContext findNextHandlerContext
]

{ #category : 'accessing' }
AIContext >> outerContext [

	^ outerContext
]

{ #category : 'accessing' }
AIContext >> outerContext: anObject [
	
	outerContext := anObject
]

{ #category : 'printing' }
AIContext >> printOn: aStream [
	aStream nextPutAll: 'AIContext: should be instantiated'
]

{ #category : 'continuation' }
AIContext >> resume: value [
	"Unwind thisContext to self and resume with value as result of last send.  Execute unwind blocks when unwinding.  ASSUMES self is a sender of thisContext"

	| ctxt unwindBlock |
	self isDead 
		ifTrue: [self cannotReturn: value to: self].
		
"	ctxt := thisContext.
	[	ctxt := ctxt findNextUnwindContextUpTo: self.
		ctxt isNil
	] whileFalse: [
		(ctxt tempAt: 2) ifNil:[
			ctxt tempAt: 2 put: true.
			unwindBlock := ctxt tempAt: 1.
			thisContext terminateTo: ctxt.
			unwindBlock value].
	]."

	thisContext terminateTo: self value: value.

]

{ #category : 'continuation' }
AIContext >> return: value [
	"Unwind thisContext to self and return value to self's sender.  Execute any unwind blocks while unwinding.  ASSUMES self is a sender of thisContext"

	"can't be nil will be root but anyway ... 
	there is 2 root the main root and a new root so can't test if root"
	self outerContext 
		ifNil: [self cannotReturn: value to: self returnContext].
		
	self outerContext resume: value
]

{ #category : 'compatibility layer' }
AIContext >> selector [
	"Answer the selector of the method that created the receiver."

	^self code selector ifNil: [self code defaultSelector].
]

{ #category : 'compatibility layer' }
AIContext >> sender [
	"to make it compatible with exceptions in Pharo code"
	
	^self homeContext
]

{ #category : 'debugging' }
AIContext >> stack [
	|context stack limit|
	
	stack := OrderedCollection new.
	context := self.
	limit := 1.
	
	[limit := limit + 1.
	context isNil or: [limit > 40]] whileFalse: [ 
		stack add: context.
		context := context homeContext. ].
	
	^ stack
]

{ #category : 'accessing' }
AIContext >> tempNamed: aName [
	self temporaries 
		at: aName 
		ifPresent: [ :value| ^ value].
	
	self homeContext 
		ifNil: [ (VariableNotDefined signalForVariable: aName context: self) == true ifTrue: [ ^ self tempNamed: aName]].
		
	^ self homeContext tempNamed: aName.
]

{ #category : 'accessing' }
AIContext >> tempNamed: aName put: aValue [
	self flag: 'the error signal doesnt work inside the interpreter '.
	(self temporaries includesKey: aName)
		ifTrue: [ ^ self temporaries at: aName put: aValue ].
	
	self homeContext 
		ifNil: [ (VariableNotDefined signalForVariable: aName context: self) == true ifTrue: [ ^ self tempNamed: aName put: aValue]].
	
	^ self homeContext tempNamed: aName put: aValue
		
]

{ #category : 'accessing' }
AIContext >> temporaries [
	^ temporaries ifNil: [ temporaries := SmallDictionary new]
]

{ #category : 'accessing' }
AIContext >> temporaries: aNameCollection [
	aNameCollection do: [ :aVarName|
		self temporaries at: aVarName put: nil ].
]

{ #category : 'continuation' }
AIContext >> terminateTo: previousContext value: aReturnValue [
	"Terminate all the Contexts between me and previousContext, if previousContext is on my Context stack. Make previousContext my sender."

	<reflective: #contextTerminateTo:message:>
	
	PrimitiveFailed signal.
	
]

{ #category : 'accessing' }
AIContext >> variableNamed: aName [

	| index |

	index := self code argumentNames indexOf: aName.
	index = 0 ifFalse: [ ^ self arguments at: index ].

	self temporaries at: aName ifPresent: [ :e | ^ e ].
	
	^ self homeContext variableNamed: aName
]
