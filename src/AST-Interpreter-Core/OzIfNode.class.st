Class {
	#name : 'OzIfNode',
	#superclass : 'OzOptimizedMessageNode',
	#instVars : [
		'trueCondition',
		'falseCondition'
	],
	#category : 'AST-Interpreter-Core-Optimized',
	#package : 'AST-Interpreter-Core',
	#tag : 'Optimized'
}

{ #category : 'visiting' }
OzIfNode >> acceptVisitor: anASTInterpreter [ 
	
	^ anASTInterpreter visitIfNode: self
]

{ #category : 'accessing' }
OzIfNode >> falseCondition [
	^ falseCondition
]

{ #category : 'as yet unclassified' }
OzIfNode >> replace: aMessageNode [

	receiver := aMessageNode receiver.
	trueCondition := aMessageNode arguments at: 1.
	falseCondition := aMessageNode arguments at: 2.
	self replace: aMessageNode with: self.
	^ self
]

{ #category : 'accessing' }
OzIfNode >> trueCondition [
	^ trueCondition
]
