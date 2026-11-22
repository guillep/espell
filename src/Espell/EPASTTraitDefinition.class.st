Class {
	#name : 'EPASTTraitDefinition',
	#superclass : 'RBProgramNode',
	#instVars : [
		'message'
	],
	#category : 'Espell-HighLevel',
	#package : 'Espell',
	#tag : 'HighLevel'
}

{ #category : 'instance creation' }
EPASTTraitDefinition class >> fromMessageNode: aMessageNode [

	^ self new
		messageNode: aMessageNode;
		yourself.
]

{ #category : 'visiting' }
EPASTTraitDefinition >> acceptVisitor: aProgramNodeVisitor [ 

	^aProgramNodeVisitor visitTraitDefinition: self
]

{ #category : 'printing' }
EPASTTraitDefinition >> formattedCode [

	^ message formattedCode
]

{ #category : 'accessing' }
EPASTTraitDefinition >> hasTraitComposition [
	
	| compositionNode |
	compositionNode := message arguments second.
	^ compositionNode isArray not or: [ compositionNode children notEmpty ]
]

{ #category : 'accessing' }
EPASTTraitDefinition >> message [

	^ message
]

{ #category : 'accessing' }
EPASTTraitDefinition >> messageNode: aMessageNode [

	message := aMessageNode.
	parent := aMessageNode parent.
	parent replaceNode: message withNode: self.
	self parent: parent.
]

{ #category : 'accessing' }
EPASTTraitDefinition >> source [
	
	^ message source
]

{ #category : 'accessing' }
EPASTTraitDefinition >> traitComposition [
	
	| traitCompositionIndex |
	traitCompositionIndex := 0.
	message selectorParts withIndexDo: [ :elem :index | elem value = 'uses:' ifTrue: [ traitCompositionIndex := index ]].

	^ message arguments at: traitCompositionIndex
]
