"
I am a specific context for the ASTInterpreter that represents MethodContext in Pharo.

Instance Variables
	receiver:		<Object>

receiver
	- is the receiver of my method

"
Class {
	#name : 'AIMethodContext',
	#superclass : 'AIContext',
	#instVars : [
		'receiver'
	],
	#category : 'AST-Interpreter-Core-Base',
	#package : 'AST-Interpreter-Core',
	#tag : 'Base'
}

{ #category : 'instance creation' }
AIMethodContext class >> fromVMContext: aMethodContext [ 
	^self new
		initializeContext: aMethodContext;
		closure: aMethodContext method;
		receiver: aMethodContext receiver;
		yourself
]

{ #category : 'testing' }
AIMethodContext >> = anAIMethodContext [
	(super = anAIMethodContext) ifFalse: [^false].
	(self receiver = anAIMethodContext receiver) ifFalse: [^false].
	^true
]

{ #category : 'debugging' }
AIMethodContext >> debugPrintString [
	^self code methodClass name, '>>#', self code printString
]

{ #category : 'accessing' }
AIMethodContext >> homeContext [
	^ self returnContext
]

{ #category : 'accessing' }
AIMethodContext >> method [
	^ self closure method
]

{ #category : 'printing' }
AIMethodContext >> printOn: aStream [
	aStream nextPutAll: 'AIMethodCtxt: '.
	aStream print: self method 
]

{ #category : 'accessing' }
AIMethodContext >> receiver [

	^ receiver
]

{ #category : 'accessing' }
AIMethodContext >> receiver: anObject [
	
	receiver := anObject
]

{ #category : 'accessing' }
AIMethodContext >> returnContext [
	^ self outerContext
]

{ #category : 'accessing' }
AIMethodContext >> returnContext: aContext [
	^ self outerContext: aContext
]
