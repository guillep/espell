Class {
	#name : 'EPCompilationTest',
	#superclass : 'EPBaseTest',
	#instVars : [
		'evaluator',
		'environment'
	],
	#category : 'Espell-Tests',
	#package : 'Espell',
	#tag : 'Tests'
}

{ #category : 'running' }
EPCompilationTest >> setUp [

	super setUp.
	evaluator := objectSpace interpreter.
	environment := EPRemoteEnvironment on: objectSpace backend systemDictionary.
]

{ #category : 'tests' }
EPCompilationTest >> testSemanticAnalysisWithClassVariable [

	| ast compilationContext |
	ast := evaluator parse: 'DependentsFields'.
	compilationContext := self class compiler compilationContext.
	compilationContext class: (environment classNamed: #Collection).
	"compilationContext requestor: (OzCompilationRequestor withTemps: someTemps)."
	ast methodNode doSemanticAnalysisInContext: compilationContext.
	
	self assert: ast isVariable.
	self assert: ast name equals: #DependentsFields.
	
	self assert: ast binding isLiteralVariable.
	
	self assert: ast binding assoc isClassVariableBinding.
	self assert: ast binding assoc name equals: #DependentsFields.
	self assert: ast binding assoc ownerName equals: #Object.
]

{ #category : 'tests' }
EPCompilationTest >> testSemanticAnalysisWithClassVariableInClassSide [

	| ast compilationContext |
	ast := evaluator parse: 'DependentsFields'.
	compilationContext := self class compiler compilationContext.
	compilationContext class: (environment classNamed: #Collection) basicClass.
	"compilationContext requestor: (OzCompilationRequestor withTemps: someTemps)."
	ast methodNode doSemanticAnalysisInContext: compilationContext.
	
	self assert: ast isVariable.
	self assert: ast name equals: #DependentsFields.
	
	self assert: ast binding isLiteralVariable.
	
	self assert: ast binding assoc isClassVariableBinding.
	self assert: ast binding assoc name equals: #DependentsFields.
	self assert: ast binding assoc ownerName equals: #Object.
]

{ #category : 'tests' }
EPCompilationTest >> testSemanticAnalysisWithGlobalVariable [

	| ast compilationContext |
	ast := evaluator parse: 'Object'.
	compilationContext := self class compiler compilationContext.
	compilationContext class: (environment classNamed: #ProtoObject).
	"compilationContext requestor: (OzCompilationRequestor withTemps: someTemps)."
	ast methodNode doSemanticAnalysisInContext: compilationContext.
	
	self assert: ast isVariable.
	self assert: ast name equals: #Object.
	
	self assert: ast binding isLiteralVariable.
	
	self assert: ast binding assoc isGlobalVariableBinding.
	self assert: ast binding assoc name equals: #Object.
]

{ #category : 'tests' }
EPCompilationTest >> testSemanticAnalysisWithPureConstants [

	| ast compilationContext |
	ast := evaluator parse: '1+1'.
	compilationContext := self class compiler compilationContext.
	compilationContext class: (environment classNamed: #ProtoObject).
	"compilationContext requestor: (OzCompilationRequestor withTemps: someTemps)."
	ast methodNode doSemanticAnalysisInContext: compilationContext.
]

{ #category : 'tests' }
EPCompilationTest >> testSemanticAnalysisWithSharedVariable [

	| ast compilationContext |
	ast := evaluator parse: 'SecondsInMinute'.
	compilationContext := self class compiler compilationContext.
	compilationContext class: (environment classNamed: #Time).
	"compilationContext requestor: (OzCompilationRequestor withTemps: someTemps)."
	ast methodNode doSemanticAnalysisInContext: compilationContext.
	
	self assert: ast isVariable.
	self assert: ast name equals: #SecondsInMinute.
	
	self assert: ast binding isLiteralVariable.
	
	self assert: ast binding assoc isClassVariableBinding.
	self assert: ast binding assoc name equals: #SecondsInMinute.
	self assert: ast binding assoc ownerName equals: #ChronologyConstants.
]
