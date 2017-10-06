tests
testSemanticAnalysisWithGlobalVariable

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