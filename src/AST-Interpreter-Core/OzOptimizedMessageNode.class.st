Class {
	#name : 'OzOptimizedMessageNode',
	#superclass : 'RBMessageNode',
	#instVars : [
		'original'
	],
	#category : 'AST-Interpreter-Core-Optimized',
	#package : 'AST-Interpreter-Core',
	#tag : 'Optimized'
}

{ #category : 'as yet unclassified' }
OzOptimizedMessageNode class >> replace: aNode [

	^ self new
		replace: aNode
]

{ #category : 'as yet unclassified' }
OzOptimizedMessageNode >> = aNode [

	^ original = aNode
]

{ #category : 'as yet unclassified' }
OzOptimizedMessageNode >> acceptVisitor: aVisitor [

	self subclassResponsibility
	"aVisitor visit**Node: self"
]

{ #category : 'as yet unclassified' }
OzOptimizedMessageNode >> arguments [

	^ original arguments
]

{ #category : 'as yet unclassified' }
OzOptimizedMessageNode >> formattedCode [

	^ original formattedCode
]

{ #category : 'as yet unclassified' }
OzOptimizedMessageNode >> isBinary [
	^ original isBinary
]

{ #category : 'as yet unclassified' }
OzOptimizedMessageNode >> isKeyword [
	^ original isKeyword
]

{ #category : 'as yet unclassified' }
OzOptimizedMessageNode >> isMessage [

	^ true
]

{ #category : 'as yet unclassified' }
OzOptimizedMessageNode >> isMessageNode [

	^ true
]

{ #category : 'as yet unclassified' }
OzOptimizedMessageNode >> isUnary [
	^ original isUnary
]

{ #category : 'as yet unclassified' }
OzOptimizedMessageNode >> keywords [

	^ original keywords
]

{ #category : 'as yet unclassified' }
OzOptimizedMessageNode >> receiver [

	^ original receiver
]

{ #category : 'as yet unclassified' }
OzOptimizedMessageNode >> replace: aNode [

	self subclassResponsibility
]

{ #category : 'as yet unclassified' }
OzOptimizedMessageNode >> replace: aNode with: anotherNode [

	original := aNode.
	aNode replaceWith: anotherNode.
]

{ #category : 'as yet unclassified' }
OzOptimizedMessageNode >> selector [

	^ original selector
]

{ #category : 'as yet unclassified' }
OzOptimizedMessageNode >> startWithoutParentheses [
	^ original startWithoutParentheses
]
