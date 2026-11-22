Class {
	#name : 'EPASTEvaluator',
	#superclass : 'Object',
	#instVars : [
		'objectSpace',
		'codeProvider',
		'interpreterClass',
		'environment',
		'astCache'
	],
	#category : 'Espell-HighLevel',
	#package : 'Espell',
	#tag : 'HighLevel'
}

{ #category : 'accessing' }
EPASTEvaluator >> builder [

	^ builder
]

{ #category : 'class-maps' }
EPASTEvaluator >> classMapAt: aClass put: aDefinition [

	classMap 
		at: aClass
		put: aDefinition
]

{ #category : 'class-maps' }
EPASTEvaluator >> classOf: anObject [

	^ self mappingOf: anObject basicClass
]

{ #category : 'accessing' }
EPASTEvaluator >> codeProvider [
	^ codeProvider
]

{ #category : 'accessing' }
EPASTEvaluator >> codeProvider: aCodeProvider [
	codeProvider := aCodeProvider
]

{ #category : 'compiling' }
EPASTEvaluator >> compile: aString [

	^ self compile: aString withTemps: #()
]

{ #category : 'compiling' }
EPASTEvaluator >> compile: aString withTemps: someTemps [
	| ast  compilationContext |
	ast := self parse: aString.
	compilationContext := self class compiler compilationContext.
	compilationContext class: (codeProvider classNamed: #ProtoObject).
	compilationContext requestor: (EPCompilationRequestor withTemps: someTemps).
	compilationContext environment: self environment.
	ast methodNode
		compilationContext: compilationContext;
		doSemanticAnalysis.
	^ ast
]

{ #category : 'accessing' }
EPASTEvaluator >> environment [
	
	^ environment ifNil: [ objectSpace environment ]
]

{ #category : 'accessing' }
EPASTEvaluator >> environment: anOzEnvironment [

	environment := anOzEnvironment
]

{ #category : 'interpreting' }
EPASTEvaluator >> evaluateAST: ast [
	
	^ self newInterpreter evaluateAST: ast.
]

{ #category : 'interpreting' }
EPASTEvaluator >> evaluateCode: someCode [

	^ self evaluateCode: someCode withTemps: #()
]

{ #category : 'interpreting' }
EPASTEvaluator >> evaluateCode: someCode withTemps: aCollectionOfTemps [

	^self evaluateAST: (self compile: someCode withTemps: aCollectionOfTemps) 
]

{ #category : 'initialize-release' }
EPASTEvaluator >> initialize [

	super initialize.
	"classMap := OzRemoteKeyDictionary new."
	interpreterClass := EPASTInterpreter.
	astCache := IdentityDictionary new.
]

{ #category : 'initialize-release' }
EPASTEvaluator >> interpreterClass: aClass [

	interpreterClass := aClass
]

{ #category : 'compiling' }
EPASTEvaluator >> isClassDefinitionSelector: aSelector [
	
	^ #(
	subclass:type:uses:instanceVariableNames:classVariableNames:classInstanceVariableNames:poolDictionaries:compactClassIndex:category:
	variableByteSubclass:instanceVariableNames:classVariableNames:
	subclass:instanceVariableNames:classVariableNames:
	variableSubclass:instanceVariableNames:classVariableNames:
	variableWordSubclass:instanceVariableNames:classVariableNames:
	weakSubclass:instanceVariableNames:classVariableNames:) includes: aSelector
]

{ #category : 'compiling' }
EPASTEvaluator >> isTraitDefinitionSelector: aSelector [
	
	^ #(named: named:uses:category:)
		includes: aSelector
]

{ #category : 'class-maps' }
EPASTEvaluator >> mappingOf: anObject [

	(anObject target species = EPSimulatorExternalObjectHandle) ifTrue: [
		anObject target object == ASTBlockClosure ifTrue: [ ^ ASTBlockClosure ].
		anObject target object == RBBlockNode ifTrue: [ ^ RBBlockNode ].
		anObject target object == OrderedCollection ifTrue: [ ^ OrderedCollection ].
		anObject target object == SmallInteger ifTrue: [ ^ SmallInteger ].
	].
	^ codeProvider classForClassMirror: anObject
	"classMap 
		at: anObject
		ifPresent: [ :mapping | ^mapping ]."
	
	"If we don't have a mapping, maybe it's just a metaclass inside the class builder. We should do a better check but..."
	"classMap 
		at: (self environment at: #Class)
		ifPresent: [ :mapping | ^ mapping ]."

	"self error: 'mapping for class not found'."
]

{ #category : 'interpreting' }
EPASTEvaluator >> newInterpreter [
	| newInterpreter |
	newInterpreter := interpreterClass new.
	newInterpreter initializeWithEvaluator: self.
	newInterpreter astCache: astCache.
	^newInterpreter.
]

{ #category : 'class-maps' }
EPASTEvaluator >> objectMirrorOnLocalObject: anObject [

	^ objectSpace objectMirrorOn: anObject
]

{ #category : 'accessing' }
EPASTEvaluator >> objectSpace [

	^ objectSpace
]

{ #category : 'accessing' }
EPASTEvaluator >> objectSpace: anObjectSpace [
	objectSpace := anObjectSpace
]

{ #category : 'compiling' }
EPASTEvaluator >> parse: aString [

	| expression |
	expression := RBParser parseExpression: aString.
	(expression isSequence and: [ environment classLoader isClassDefinition: aString ])
		ifTrue: [ expression := EPASTClassDefinition fromMessageNode: expression ].
	(expression isMessage and: [ self isTraitDefinitionSelector: expression selector ])
		ifTrue: [ expression := EPASTTraitDefinition fromMessageNode: expression ].
	^ expression
]
