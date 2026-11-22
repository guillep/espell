Class {
	#name : 'OzOptimizedMethodAccessorNode',
	#superclass : 'OzOptimizedMethodNode',
	#instVars : [
		'variableNode'
	],
	#category : 'AST-Interpreter-Core-Optimized',
	#package : 'AST-Interpreter-Core',
	#tag : 'Optimized'
}

{ #category : 'enumerating' }
OzOptimizedMethodAccessorNode class >> replace: aNode [

	^ self new
		replace: aNode
]

{ #category : 'executing' }
OzOptimizedMethodAccessorNode >> index [

	^ variableNode binding index
]

{ #category : 'executing' }
OzOptimizedMethodAccessorNode >> name [

	^ variableNode name
]
