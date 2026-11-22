Class {
	#name : 'OzOptimizedMethodNode',
	#superclass : 'RBMethodNode',
	#instVars : [
		'original'
	],
	#category : 'AST-Interpreter-Core-Optimized',
	#package : 'AST-Interpreter-Core',
	#tag : 'Optimized'
}

{ #category : 'enumerating' }
OzOptimizedMethodNode class >> replace: aNode [

	^ self new
		replace: aNode
]

{ #category : 'as yet unclassified' }
OzOptimizedMethodNode >> arguments [
	^ original arguments
]

{ #category : 'as yet unclassified' }
OzOptimizedMethodNode >> replace: aMethodNode [

	self replace: aMethodNode with: self.
	^ self
]

{ #category : 'as yet unclassified' }
OzOptimizedMethodNode >> replace: aNode with: anotherNode [

	original := aNode
]

{ #category : 'as yet unclassified' }
OzOptimizedMethodNode >> selector [
	^ original selector
]
