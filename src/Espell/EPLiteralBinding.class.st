Class {
	#name : 'EPLiteralBinding',
	#superclass : 'Object',
	#instVars : [
		'name',
		'objectSpace',
		'environment'
	],
	#category : 'Espell-HighLevel',
	#package : 'Espell',
	#tag : 'HighLevel'
}

{ #category : 'as yet unclassified' }
EPLiteralBinding class >> fromSton: stonReader [

	| binding |
	binding := self new.
	stonReader parseListDo: [ :each |
		binding name: each ].
	^ binding
]

{ #category : 'comparing' }
EPLiteralBinding >> = another [ 

	^ self name = another name
]

{ #category : 'analyzing' }
EPLiteralBinding >> analyzeRead: aRBVariableNode by: anOCASTSemanticAnalyzer [ 

	
]

{ #category : 'analyzing' }
EPLiteralBinding >> analyzeWrite: aVariableNode by: aSemanticAnalyzer [
]

{ #category : 'literal resolution' }
EPLiteralBinding >> asLiteralInObjectSpace: anObjectSpace [
	self subclassResponsibility
]

{ #category : 'literal resolution' }
EPLiteralBinding >> beStrict [

	noBindingBlock := [ self error: 'There is no global: ', name asString ].
]

{ #category : 'compiling' }
EPLiteralBinding >> emitStore: methodBuilder [
	methodBuilder storeIntoLiteralVariable: self.
]

{ #category : 'compiling' }
EPLiteralBinding >> emitValue: methodBuilder [
	methodBuilder pushLiteralVariable: self.
]

{ #category : 'accessing' }
EPLiteralBinding >> environment [
	
	^ environment
]

{ #category : 'accessing' }
EPLiteralBinding >> environment: anOzEnvironment [

	environment := anOzEnvironment
]

{ #category : 'comparing' }
EPLiteralBinding >> hash [

	^ self name hash
]

{ #category : 'initialize-release' }
EPLiteralBinding >> initialize [

	super initialize.
	noBindingBlock := [ objectSpace nilObject ]
]

{ #category : 'testing' }
EPLiteralBinding >> isSuperVariable [
	
	^ false
]

{ #category : 'testing' }
EPLiteralBinding >> isVariableBinding [
	^true
]

{ #category : 'accessing' }
EPLiteralBinding >> key [
	^name
]

{ #category : 'accessing' }
EPLiteralBinding >> name [
	^name
]

{ #category : 'accessing' }
EPLiteralBinding >> name: aName [

	name := aName
]

{ #category : 'initialize-release' }
EPLiteralBinding >> name: aBindingName objectSpace: anObjectSpace [
	name := aBindingName.
	objectSpace := anObjectSpace.
]

{ #category : 'initialize-release' }
EPLiteralBinding >> objectSpace: anObjectSpace [

	objectSpace := anObjectSpace
]

{ #category : 'as yet unclassified' }
EPLiteralBinding >> printOn: aStream [

	aStream nextPutAll: self class name, '(', name, ')'
]

{ #category : 'accessing' }
EPLiteralBinding >> sourceEnvironment [
	self shouldBeImplemented.
]

{ #category : 'accessing' }
EPLiteralBinding >> value [

	^ (objectSpace classNamed: name) mirror
]
