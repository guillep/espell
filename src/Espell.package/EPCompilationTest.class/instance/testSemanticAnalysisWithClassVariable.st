tests
testSemanticAnalysisWithClassVariable

	| ast compilationContext |
	ast := evaluator parse: 'DependentsFields'.
	compilationContext := self class compiler compilationContext.
	compilationContext class: (environment classNamed: #Collection).
	"compilationContext requestor: (OzCompilationRequestor withTemps: someTemps)."
	ast methodNode compilationContext: compilationContext.
	ast methodNode doSemanticAnalysis.

	self assert: ast isVariable.
	self assert: ast name equals: #DependentsFields.
	
	self assert: ast binding isLiteralVariable.
	
	self assert: ast binding assoc isClassVariableBinding.
	self assert: ast binding assoc name equals: #DependentsFields.
	self assert: ast binding assoc ownerName equals: #Object.