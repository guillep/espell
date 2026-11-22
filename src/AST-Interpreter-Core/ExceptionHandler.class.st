"
I represent the BlockClosure>>on:do: temporaries in Pharo.

Instance Variables
	block:		<ASTBlockClosure>
	enabled:		<Boolean>
	exception:		<Exception>

block
	- is the handler block

enabled
	- is false if not active (to avoid running twice an handler block))

exception
	- is the exceptionClass

"
Class {
	#name : 'ExceptionHandler',
	#superclass : 'Object',
	#instVars : [
		'block',
		'exception'
	],
	#category : 'AST-Interpreter-Core-Base',
	#package : 'AST-Interpreter-Core',
	#tag : 'Base'
}

{ #category : 'instance-creation' }
ExceptionHandler class >> forMessage: aMessage [
	^ self 
		on: aMessage arguments first
		do: aMessage arguments second
]

{ #category : 'instance-creation' }
ExceptionHandler class >> on: anException do: aBlock [
	^ self new
		exception: anException;
		block: aBlock;
		yourself
]

{ #category : 'accessing' }
ExceptionHandler >> block [

	^ block
]

{ #category : 'accessing' }
ExceptionHandler >> block: aBlock [
	
	block := aBlock
]

{ #category : 'accessing' }
ExceptionHandler >> exception [

	^ exception
]

{ #category : 'accessing' }
ExceptionHandler >> exception: anException [

	exception := anException
]

{ #category : 'exception-handling' }
ExceptionHandler >> handle: anError [

	self flag: 'TODO:do the ensure magic here..
	instead of ^ there is resume: that trigger all the unwind block in Pharo
	I think there should be some gotoContext changes here'.
	^self block cull: anError
]

{ #category : 'testing' }
ExceptionHandler >> handles: anError [

	^self exception handles: anError
]
