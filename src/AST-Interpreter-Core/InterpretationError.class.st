"
I signal when there is an Error in  the interpretation of the code in the ASTInterpreter. In my cause instance variable you can the see the original class of the Error.

"
Class {
	#name : 'InterpretationError',
	#superclass : 'Error',
	#instVars : [
		'cause'
	],
	#category : 'AST-Interpreter-Core-Exceptions',
	#package : 'AST-Interpreter-Core',
	#tag : 'Exceptions'
}

{ #category : 'signalling' }
InterpretationError class >> signalFor: aCauseError [
	^ self new
		cause: aCauseError;
		signal
]

{ #category : 'accessing' }
InterpretationError >> cause [

	^ cause
]

{ #category : 'accessing' }
InterpretationError >> cause: anObject [
	
	cause := anObject
]

{ #category : 'private' }
InterpretationError >> isResumable [
	^ true
]
