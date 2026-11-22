Class {
	#name : 'EPASTClassDefinition',
	#superclass : 'RBProgramNode',
	#instVars : [
		'message'
	],
	#category : 'Espell-HighLevel',
	#package : 'Espell',
	#tag : 'HighLevel'
}

{ #category : 'instance creation' }
EPASTClassDefinition class >> fromMessageNode: aMessageNode [

	^ self new
		messageNode: aMessageNode;
		yourself.
]

{ #category : 'visiting' }
EPASTClassDefinition >> acceptVisitor: aProgramNodeVisitor [ 

	^aProgramNodeVisitor visitClassDefinition: self
]

{ #category : 'accessing' }
EPASTClassDefinition >> classPool [
	

	| assignmentNode block |
	assignmentNode := message statements first.
	block := assignmentNode value arguments first.
	^ block body statements first messages fifth arguments first
		value substrings collect: [ :name | RBVariableNode named: name asSymbol ].
]

{ #category : 'printing' }
EPASTClassDefinition >> formattedCode [

	^ message formattedCode
]

{ #category : 'accessing' }
EPASTClassDefinition >> hasTraitComposition [
	
	| compositionNode |
	
	message statements second isMessage ifFalse: [ ^ false ].
	
	compositionNode := message statements second arguments first receiver.
	^ compositionNode isArray not or: [ compositionNode children notEmpty ]
]

{ #category : 'accessing' }
EPASTClassDefinition >> message [

	^ message
]

{ #category : 'accessing' }
EPASTClassDefinition >> messageNode: aMessageNode [

	message := aMessageNode.
	parent := aMessageNode parent.
	parent replaceNode: message withNode: self.
	self parent: parent.
]

{ #category : 'accessing' }
EPASTClassDefinition >> name [
	self halt.
	^ (message arguments at: 1) value
]

{ #category : 'accessing' }
EPASTClassDefinition >> sharedPools [
	

	| assignmentNode block |
	assignmentNode := message statements first.
	block := assignmentNode value arguments first.
	^ block body statements first messages sixth arguments first
		value substrings collect: [ :name | RBVariableNode named: name asSymbol ].
]

{ #category : 'accessing' }
EPASTClassDefinition >> source [
	
	^ message source
]

{ #category : 'accessing' }
EPASTClassDefinition >> start [
	^ message start
]

{ #category : 'accessing' }
EPASTClassDefinition >> stop [
	^ message stop
]

{ #category : 'accessing' }
EPASTClassDefinition >> superclass [

	| assignmentNode block |
	assignmentNode := message statements first.
	block := assignmentNode value arguments first.
	^ block body statements first messages first arguments first.
]

{ #category : 'accessing' }
EPASTClassDefinition >> temporaries [
	
	^ message temporaries
]

{ #category : 'accessing' }
EPASTClassDefinition >> temporaryNames [
	
	^ message temporaryNames
]

{ #category : 'accessing' }
EPASTClassDefinition >> traitComposition [
	
	^ message statements second arguments first
]
