Class {
	#name : 'OzAccessorWriteNode',
	#superclass : 'OzOptimizedMethodAccessorNode',
	#category : 'AST-Interpreter-Core-Optimized',
	#package : 'AST-Interpreter-Core',
	#tag : 'Optimized'
}

{ #category : 'enumerating' }
OzAccessorWriteNode class >> replace: aNode [

	^ self new
		replace: aNode
]

{ #category : 'executing' }
OzAccessorWriteNode >> accept: visitor on: receiver message: aMessage [
	
	^ receiver instanceVariableAtIndex: self index put: aMessage arguments first
]

{ #category : 'executing' }
OzAccessorWriteNode >> replace: aMethodNode [

	variableNode := aMethodNode body statements first variable.
	self replace: aMethodNode with: self.
	^ self
]
