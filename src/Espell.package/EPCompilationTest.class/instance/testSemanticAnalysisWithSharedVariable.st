tests
testSemanticAnalysisWithSharedVariable

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