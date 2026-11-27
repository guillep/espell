Class {
	#name : #EPCompilationTest,
	#superclass : #EPBaseTest,
	#instVars : [
		'environment'
	],
	#category : #'Espell-Tests'
}

{ #category : #running }
EPCompilationTest >> setUp [

	super setUp.
	environment := EPRemoteEnvironment on: self backend systemDictionary
]

{ #category : #tests }
EPCompilationTest >> testSemanticAnalysisWithClassVariable [

	| ast compilationContext |
	ast := RBParser parseExpression: 'DependentsFields'.
	compilationContext := self class compiler compilationContext.
	compilationContext class: (environment classNamed: #Collection).
	"compilationContext requestor: (OzCompilationRequestor withTemps: someTemps)."
	ast methodNode
		compilationContext: compilationContext;
		doSemanticAnalysis.
	
	self assert: ast isVariable.
	self assert: ast name equals: #DependentsFields.
	
	self assert: ast binding isClassVariableBinding.
	self assert: ast binding name equals: #DependentsFields.
	self assert: ast binding ownerName equals: #Object.
]

{ #category : #tests }
EPCompilationTest >> testSemanticAnalysisWithClassVariableInClassSide [

	| ast compilationContext |
	ast := RBParser parseExpression: 'DependentsFields'.
	compilationContext := self class compiler compilationContext.
	compilationContext class: (environment classNamed: #Collection) basicClass.
	"compilationContext requestor: (OzCompilationRequestor withTemps: someTemps)."
	ast methodNode
		compilationContext: compilationContext;
		doSemanticAnalysis.
	
	self assert: ast isVariable.
	self assert: ast name equals: #DependentsFields.
	
	self assert: ast binding isClassVariableBinding.
	self assert: ast binding name equals: #DependentsFields.
	self assert: ast binding ownerName equals: #Object.
]

{ #category : #tests }
EPCompilationTest >> testSemanticAnalysisWithGlobalVariable [

	| ast compilationContext |
	ast := RBParser parseExpression: 'Object'.
	compilationContext := self class compiler compilationContext.
	compilationContext class: (environment classNamed: #ProtoObject).
	"compilationContext requestor: (OzCompilationRequestor withTemps: someTemps)."
	ast methodNode
		compilationContext: compilationContext;
		doSemanticAnalysis.
	
	self assert: ast isVariable.
	self assert: ast name equals: #Object.
	
	self assert: ast binding isGlobalVariableBinding.
	self assert: ast binding name equals: #Object.
]

{ #category : #tests }
EPCompilationTest >> testSemanticAnalysisWithPureConstants [

	| ast compilationContext |
	ast := RBParser parseExpression: '1+1'.
	compilationContext := self class compiler compilationContext.
	compilationContext class: (environment classNamed: #ProtoObject).
	"compilationContext requestor: (OzCompilationRequestor withTemps: someTemps)."
	ast methodNode
		compilationContext: compilationContext;
		doSemanticAnalysis.
]

{ #category : #tests }
EPCompilationTest >> testSemanticAnalysisWithSharedVariable [

	| ast compilationContext |
	ast := RBParser parseExpression: 'SecondsInMinute'.
	compilationContext := self class compiler compilationContext.
	compilationContext class: (environment classNamed: #Time).
	"compilationContext requestor: (OzCompilationRequestor withTemps: someTemps)."
	ast methodNode
		compilationContext: compilationContext;
		doSemanticAnalysis.
	
	self assert: ast isVariable.
	self assert: ast name equals: #SecondsInMinute.
	
	self assert: ast binding isClassVariableBinding.
	self assert: ast binding name equals: #SecondsInMinute.
	self assert: ast binding ownerName equals: #ChronologyConstants.
]
