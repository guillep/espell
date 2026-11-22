Class {
	#name : 'OzIfFalseNode',
	#superclass : 'OzOptimizedMessageNode',
	#instVars : [
		'falseCondition'
	],
	#category : 'AST-Interpreter-Core-Optimized',
	#package : 'AST-Interpreter-Core',
	#tag : 'Optimized'
}

{ #category : 'visiting' }
OzIfFalseNode >> acceptVisitor: aVisitor [

	^ aVisitor visitIfFalseNode: self
]

{ #category : 'accessing' }
OzIfFalseNode >> falseCondition [
	^ falseCondition
]

{ #category : 'as yet unclassified' }
OzIfFalseNode >> replace: aMessageNode [

	receiver := aMessageNode receiver.
	falseCondition := aMessageNode arguments at: 1.
	self replace: aMessageNode with: self.
	^ self
]
