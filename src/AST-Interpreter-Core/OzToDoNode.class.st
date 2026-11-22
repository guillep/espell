Class {
	#name : 'OzToDoNode',
	#superclass : 'OzOptimizedMessageNode',
	#instVars : [
		'fromNode',
		'toNode',
		'blockNode'
	],
	#category : 'AST-Interpreter-Core-Optimized',
	#package : 'AST-Interpreter-Core',
	#tag : 'Optimized'
}

{ #category : 'visiting' }
OzToDoNode >> acceptVisitor: aVisitor [
	^ aVisitor visitToDoNode: self
]

{ #category : 'accessing' }
OzToDoNode >> blockNode [
	^ blockNode
]

{ #category : 'accessing' }
OzToDoNode >> fromNode [
	^ fromNode
]

{ #category : 'as yet unclassified' }
OzToDoNode >> replace: aMessageNode [

	fromNode := aMessageNode receiver.
	toNode := aMessageNode arguments at: 1.
	blockNode := aMessageNode arguments at: 2.
	self replace: aMessageNode with: self.
	^ self
]

{ #category : 'accessing' }
OzToDoNode >> toNode [
	^ toNode
]
