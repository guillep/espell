Class {
	#name : 'OzAccessorReadNode',
	#superclass : 'OzOptimizedMethodAccessorNode',
	#category : 'AST-Interpreter-Core-Optimized',
	#package : 'AST-Interpreter-Core',
	#tag : 'Optimized'
}

{ #category : 'enumerating' }
OzAccessorReadNode class >> replace: aNode [

	^ self new
		replace: aNode
]

{ #category : 'executing' }
OzAccessorReadNode >> accept: visitor on: receiver message: aMessage [
	
	^ receiver instanceVariableAtIndex: self index
]

{ #category : 'executing' }
OzAccessorReadNode >> index [

	^ variableNode binding index
]

{ #category : 'executing' }
OzAccessorReadNode >> name [

	^ variableNode name
]

{ #category : 'executing' }
OzAccessorReadNode >> replace: aMethodNode [

	variableNode := aMethodNode body statements first value.
	self replace: aMethodNode with: self.
	^ self
]
