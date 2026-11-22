Class {
	#name : 'EPRealLiteralBinding',
	#superclass : 'EPLiteralBinding',
	#instVars : [
		'value'
	],
	#category : 'Espell-HighLevel',
	#package : 'Espell',
	#tag : 'HighLevel'
}

{ #category : 'instance creation' }
EPRealLiteralBinding class >> name: aName value: aValue [

	^ self new
		name: aName;
		value: aValue;
		yourself
]

{ #category : 'visiting' }
EPRealLiteralBinding >> acceptVisitor: aProgramNodeVisitor node: aNode [

	^ aProgramNodeVisitor visitGlobalVariableNode: aNode
]

{ #category : 'testing' }
EPRealLiteralBinding >> isGlobalVariable [
	
	^ true
]

{ #category : 'accessing' }
EPRealLiteralBinding >> readWith: anEPASTInterpreter inNode: aRBVariableNode [ 
	^ value
]

{ #category : 'accessing' }
EPRealLiteralBinding >> value [

	^ value
]

{ #category : 'accessing' }
EPRealLiteralBinding >> value: aValue [

	value := aValue
]
