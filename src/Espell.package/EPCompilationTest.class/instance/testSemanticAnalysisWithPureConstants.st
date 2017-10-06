tests
testSemanticAnalysisWithPureConstants

	| ast compilationContext |
	ast := evaluator parse: '1+1'.
	compilationContext := self class compiler compilationContext.
	compilationContext class: (environment classNamed: #ProtoObject).
	"compilationContext requestor: (OzCompilationRequestor withTemps: someTemps)."
	ast methodNode doSemanticAnalysisInContext: compilationContext.