Class {
	#name : 'EPGlobalBinding',
	#superclass : 'EPLiteralBinding',
	#category : 'Espell-HighLevel',
	#package : 'Espell',
	#tag : 'HighLevel'
}

{ #category : 'accessing' }
EPGlobalBinding >> accept: anEPASTInterpreter assign: anEPMirror inNode: aRBVariableNode [ 
	
	anEPASTInterpreter environment globalNamed: name put: anEPMirror
]

{ #category : 'visiting' }
EPGlobalBinding >> acceptVisitor: aProgramNodeVisitor node: aNode [

	^ aProgramNodeVisitor visitGlobalVariableNode: aNode
]

{ #category : 'analyzing' }
EPGlobalBinding >> analyzeRead: aRBVariableNode by: anOCASTSemanticAnalyzer [ 

	
]

{ #category : 'literal resolution' }
EPGlobalBinding >> asLiteralInObjectSpace: anObjectSpace [

	| binding |
	binding := (EPRemoteEnvironment on: anObjectSpace backend systemDictionary) bindingOf: name asSymbol.
	"If we did not find a binding for the given global, it means that the global is not declared in the bootstrap.
	1) We then create an undeclared in the undeclared dictionary
	2) We return the new binding"
	^ binding ifNil: [ 
		self haltIf: [ name ~= #Display ].
		objectSpace bootstrapInterpreter
			evaluateCode: 'Undeclared at: undeclaredName put: nil.
								Undeclared associationAt: undeclaredName'
			withTemps: { 
				'undeclaredName' -> (name asSymbol asLiteralInObjectSpace: anObjectSpace)
			}.
		]
]

{ #category : 'testing' }
EPGlobalBinding >> isGlobalClassNameBinding [
	
	"For bootstrapping purposes, all variables are writtable.
	We need to implement this method because Opal is not modular enough so far."
	
	^ false
]

{ #category : 'testing' }
EPGlobalBinding >> isGlobalVariable [
	
	^ true
]

{ #category : 'testing' }
EPGlobalBinding >> isGlobalVariableBinding [
	
	^ true
]

{ #category : 'accessing' }
EPGlobalBinding >> readWith: anEPASTInterpreter inNode: aRBVariableNode [ 
	
	^ anEPASTInterpreter environment globalNamed: name
]

{ #category : 'accessing' }
EPGlobalBinding >> value: anObject [
	"we keep track in the local representation of the environment of the object space"
	environment at: self name put: anObject.
	objectSpace environment addGlobal: self name pointingTo: anObject.

	^super value: anObject.	
]
