Class {
	#name : 'EPClassVariableBinding',
	#superclass : 'EPLiteralBinding',
	#instVars : [
		'ownerName',
		'binding'
	],
	#category : 'Espell-HighLevel',
	#package : 'Espell',
	#tag : 'HighLevel'
}

{ #category : 'as yet unclassified' }
EPClassVariableBinding class >> fromSton: stonReader [

	| binding |
	binding := self new.
	stonReader parseListDo: [ :each :index |
		index = 1 ifTrue: [binding name: each].
		index = 2 ifTrue: [binding ownerName: each] ].
	^ binding
]

{ #category : 'visitor' }
EPClassVariableBinding >> accept: anEPASTInterpreter assign: anEPMirror inNode: aRBVariableNode [ 
	
	^ (anEPASTInterpreter environment classNamed: ownerName)
			classPool at: name put: anEPMirror
]

{ #category : 'visiting' }
EPClassVariableBinding >> acceptVisitor: aProgramNodeVisitor node: aNode [

	^ aProgramNodeVisitor visitClassVariableNode: aNode
]

{ #category : 'literal resolution' }
EPClassVariableBinding >> asLiteralInEnvironment: anEnvironment [
	^ binding
		ifNil: [ 
			| currentClass |
			currentClass := anEnvironment classNamed: ownerName.
			[ currentClass isNilObject ]
				whileFalse: [ 
					(currentClass includesClassVariableNamed: self name)
						ifTrue: [ ^ binding := currentClass classPool basicBindingOf: self name ].
					currentClass := currentClass superclass ].
			self error: ('Variable {1} not defined' format: {(self printString)}) ]
]

{ #category : 'literal resolution' }
EPClassVariableBinding >> asLiteralInObjectSpace: anObjectSpace [

	^ ((objectSpace classNamed: ownerName)
			classPool bindingOf: name)
]

{ #category : 'testing' }
EPClassVariableBinding >> isClassVariableBinding [
	
	^ true
]

{ #category : 'testing' }
EPClassVariableBinding >> isGlobalVariable [
	
	^ false
]

{ #category : 'initialize-release' }
EPClassVariableBinding >> name: aBindingName ownerName: anOwnerName objectSpace: anObjectSpace [
	self ownerName: anOwnerName.
	self name: aBindingName objectSpace: anObjectSpace.
]

{ #category : 'accessing' }
EPClassVariableBinding >> ownerName [
	^ ownerName
]

{ #category : 'initialize-release' }
EPClassVariableBinding >> ownerName: anOwnerName [
	
	ownerName := anOwnerName
]

{ #category : 'literal resolution' }
EPClassVariableBinding >> printOn: aStream [

	aStream
		nextPutAll: ownerName;
		nextPutAll: ' => ';
		nextPutAll: name.
]

{ #category : 'accessing' }
EPClassVariableBinding >> readWith: anEPASTInterpreter inNode: aRBVariableNode [ 
	
	^ (anEPASTInterpreter environment classNamed: ownerName)
			classPool at: name
]

{ #category : 'literal resolution' }
EPClassVariableBinding >> value [
	"we keep track in the remote representation"
	^(self asLiteralInObjectSpace: objectSpace) instanceVariableAtIndex: 2
]

{ #category : 'literal resolution' }
EPClassVariableBinding >> value: anObject [
	"we keep track in the remote representation"
	^(self asLiteralInObjectSpace: objectSpace) instanceVariableAtIndex: 2 put: anObject
]
