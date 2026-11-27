"
I am the AST interpreter of the tests of Espell. I compile the methods I interpret against an `EPTestClassDefinition`, where the bootstrap uses `PBClassDefinition`, so that the tests do not need PharoBootstrap.

`EPTestKernel>>#createInterpreter` gives my class to its `EPASTEvaluator`.
"
Class {
	#name : #EPTestASTInterpreter,
	#superclass : #EPASTInterpreter,
	#category : #'Espell-Tests'
}

{ #category : #'method evaluation' }
EPTestASTInterpreter >> classDefinitionOn: aClassDefinition [

	^ EPTestClassDefinition on: aClassDefinition environment: evaluator environment
]
