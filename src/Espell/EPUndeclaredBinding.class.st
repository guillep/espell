Class {
	#name : 'EPUndeclaredBinding',
	#superclass : 'EPLiteralBinding',
	#category : 'Espell-HighLevel',
	#package : 'Espell',
	#tag : 'HighLevel'
}

{ #category : 'visiting' }
EPUndeclaredBinding >> acceptVisitor: aProgramNodeVisitor node: aNode [

	^ aProgramNodeVisitor visitGlobalVariableNode: aNode
]

{ #category : 'converting' }
EPUndeclaredBinding >> asLiteralInObjectSpace: anObjectSpace [
	"If we did not find a binding for the given global, it means that the global is not declared in the bootstrap.
	1) We then create an undeclared in the undeclared dictionary
	2) We return the new binding"
	^ objectSpace bootstrapInterpreter
			evaluateCode: 'Undeclared at: undeclaredName put: nil.
								Undeclared associationAt: undeclaredName'
			withTemps: { 
				'undeclaredName' -> (name asSymbol asLiteralInObjectSpace: anObjectSpace)
			}.
]

{ #category : 'testing' }
EPUndeclaredBinding >> isGlobalVariable [
	
	^ false
]

{ #category : 'testing' }
EPUndeclaredBinding >> isTemp [
	
	^ false
]

{ #category : 'testing' }
EPUndeclaredBinding >> isUninitialized [
	
	^ false
]

{ #category : 'accessing' }
EPUndeclaredBinding >> semanticNodeClass [
	
	^ RBVariableNode
]
