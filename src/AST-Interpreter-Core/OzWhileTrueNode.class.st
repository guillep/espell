Class {
	#name : 'OzWhileTrueNode',
	#superclass : 'OzOptimizedMessageNode',
	#instVars : [
		'condition',
		'isWhileFalse'
	],
	#category : 'AST-Interpreter-Core-Optimized',
	#package : 'AST-Interpreter-Core',
	#tag : 'Optimized'
}

{ #category : 'visiting' }
OzWhileTrueNode >> acceptVisitor: aVisitor [
	^ aVisitor visitWhileTrueNode: self
]

{ #category : 'accessing' }
OzWhileTrueNode >> condition [
	^ condition
]

{ #category : 'visiting' }
OzWhileTrueNode >> expectedBooleanValue [
	
	^ isWhileFalse ifTrue: [ 'False' ] ifFalse: [ 'True' ]
]

{ #category : 'as yet unclassified' }
OzWhileTrueNode >> replace: aMessageNode [

	isWhileFalse := aMessageNode selector beginsWith: 'whileFalse'.
	receiver := aMessageNode receiver.
	condition := aMessageNode arguments isEmpty
		ifTrue: [ RBLiteralNode value: nil ]
		ifFalse: [ (aMessageNode arguments at: 1) body ].
	self replace: aMessageNode with: self.
	^ self
]
