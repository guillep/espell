compiling
compile: aString withTemps: someTemps
	| ast  compilationContext |
	ast := self parse: aString.
	compilationContext := self class compiler compilationContext.
	compilationContext class: (codeProvider classNamed: (codeProvider systemDefinition classWithRole: #ProtoObject) name).
	compilationContext requestor: (EPCompilationRequestor withTemps: someTemps).
	compilationContext environment: self environment.
	ast methodNode
		compilationContext: compilationContext;
		doSemanticAnalysis.
	^ ast