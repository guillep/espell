"
I am an error that is triggered when a variable not defined in a context is called.

It is catched in case of a DoIt because there you don't need to declare temporaries.
"
Class {
	#name : 'VariableNotDefined',
	#superclass : 'Error',
	#instVars : [
		'variableName',
		'context'
	],
	#category : 'AST-Interpreter-Core-Exceptions',
	#package : 'AST-Interpreter-Core',
	#tag : 'Exceptions'
}

{ #category : 'as yet unclassified' }
VariableNotDefined class >> signalForVariable: aName context: aContext [
	^self new 
		variableName: aName;
		context: aContext;
		signal
]

{ #category : 'accessing' }
VariableNotDefined >> context [
	^ context
]

{ #category : 'accessing' }
VariableNotDefined >> context: anObject [
	context := anObject
]

{ #category : 'handling' }
VariableNotDefined >> createTemp [
	context createTemp: variableName
]

{ #category : 'testing' }
VariableNotDefined >> isResumable [
	^true
]

{ #category : 'accessing' }
VariableNotDefined >> variableName [
	^ variableName
]

{ #category : 'accessing' }
VariableNotDefined >> variableName: anObject [
	variableName := anObject
]
