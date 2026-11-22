"
I am a specific context for the ASTInterpreter that represents BlockContext in Pharo. I have one aditional role with is to manage myself the exception handling and I do not delegate it to the context of the BlockClosure>>on:do: method

Instance Variables
	exceptionHandler:		<ExceptionHandler>
	homeContext:		<AIContext>

exceptionHandler
	- is nil if there are no exception handler 
	  is an ExceptionHandler which represents an ExceptionClass, a handlerBlock and the isActive boolean. It represents in Pharo the temporaries of the BlockClosure>>on:do: method

homeContext
	- is the homeContext of the BlockClosure
	 <is duplicated with ASTBlockClosure - homeContext>

"
Class {
	#name : 'AIBlockContext',
	#superclass : 'AIContext',
	#instVars : [
		'homeContext',
		'exceptionHandler'
	],
	#category : 'AST-Interpreter-Core-Base',
	#package : 'AST-Interpreter-Core',
	#tag : 'Base'
}

{ #category : 'instance creation' }
AIBlockContext class >> fromVMContext: aBlockContext [
	|sender|
	sender := aBlockContext sender.
	^ self new 
		initializeContext: aBlockContext;
		homeContext: aBlockContext home asASTInterpreterContext ; 
		closure: aBlockContext closure asASTBlockClosure;
		exceptionHandler: (sender ifNotNil: [ 
			sender isHandlerContext ifTrue: [
				ExceptionHandler on: (sender tempAt: 1) do: (sender tempAt: 2)]
			]) ;
		yourself
]

{ #category : 'testing' }
AIBlockContext >> = anAIBlockContext [

	(super = anAIBlockContext) ifFalse: [^false].
	(self homeContext = anAIBlockContext homeContext) ifFalse: [^false].
	(self exceptionHandler = anAIBlockContext exceptionHandler) ifFalse: [^false].
	^true
]

{ #category : 'debugging' }
AIBlockContext >> debugPrintString [
	^'Block in : ', 
		self methodClass name, 
		'>>#', 
		(self method ifNotNil: [:mth | mth selector] ifNil: [#unknownSelector]), 
		String lf, 
		self code formattedCode printString
]

{ #category : 'accessing' }
AIBlockContext >> exceptionHandler [
	^ exceptionHandler
]

{ #category : 'accessing' }
AIBlockContext >> exceptionHandler: anExceptionHandler [
	exceptionHandler := anExceptionHandler
]

{ #category : 'testing' }
AIBlockContext >> hasExceptionHandler [
	^ exceptionHandler isNil not
]

{ #category : 'accessing' }
AIBlockContext >> homeContext [

	^ homeContext
]

{ #category : 'accessing' }
AIBlockContext >> homeContext: aContext [

	homeContext := aContext
]

{ #category : 'accessing' }
AIBlockContext >> method [
	^ self homeContext method
]

{ #category : 'accessing' }
AIBlockContext >> methodClass [
	^ self homeContext methodClass
]

{ #category : 'printing' }
AIBlockContext >> printOn: aStream [
	aStream nextPutAll: 'AIBlockCtxt: '.
	aStream nextPutAll: self code formattedCode
]

{ #category : 'accessing' }
AIBlockContext >> receiver [
	^ self homeContext receiver
]

{ #category : 'accessing' }
AIBlockContext >> returnContext [
	^ self homeContext returnContext
]
