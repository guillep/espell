Class {
	#name : 'OzIfTrueNode',
	#superclass : 'OzOptimizedMessageNode',
	#instVars : [
		'trueCondition'
	],
	#category : 'AST-Interpreter-Core-Optimized',
	#package : 'AST-Interpreter-Core',
	#tag : 'Optimized'
}

{ #category : 'visiting' }
OzIfTrueNode >> acceptVisitor: aVisitor [
	^ aVisitor visitIfTrueNode: self
]

{ #category : 'as yet unclassified' }
OzIfTrueNode >> replace: aMessageNode [

	receiver := aMessageNode receiver.
	trueCondition := aMessageNode arguments at: 1.
	self replace: aMessageNode with: self.
	^ self
]

{ #category : 'accessing' }
OzIfTrueNode >> trueCondition [
	^ trueCondition
]
