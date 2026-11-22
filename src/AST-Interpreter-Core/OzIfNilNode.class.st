Class {
	#name : 'OzIfNilNode',
	#superclass : 'OzOptimizedMessageNode',
	#instVars : [
		'trueCondition',
		'falseCondition',
		'checkForNil'
	],
	#category : 'AST-Interpreter-Core-Optimized',
	#package : 'AST-Interpreter-Core',
	#tag : 'Optimized'
}

{ #category : 'visiting' }
OzIfNilNode >> acceptVisitor: aVisitor [
	
	^ aVisitor visitIfNilNode: self
]

{ #category : 'accessing' }
OzIfNilNode >> checkForNil [
	^ checkForNil
]

{ #category : 'accessing' }
OzIfNilNode >> falseCondition [
	^ falseCondition
]

{ #category : 'as yet unclassified' }
OzIfNilNode >> replace: aMessageNode [

	checkForNil := aMessageNode selector beginsWith: 'ifNil'.
	receiver := aMessageNode receiver.
	trueCondition := aMessageNode arguments at: 1.
	falseCondition := aMessageNode arguments size > 1
		ifTrue: [ (aMessageNode arguments at: 2) body ]
		ifFalse: [ RBLiteralNode value: nil ].
	
	trueCondition isBlock	ifFalse: [ ^ nil ].
	
	self replace: aMessageNode with: self.
	^ self
]

{ #category : 'accessing' }
OzIfNilNode >> trueCondition [
	^ trueCondition
]
