initialize-release
initializeAstOfMethodDefinition: definition fromBehavior: mirror
	ASTCache
		at: definition
		put: (definition generateASTBindedTo: mirror inObjectSpace: evaluator objectSpace)