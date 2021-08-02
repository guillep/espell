*AST-Interpreter-Extension
visitTraitDefinition: anEPASTClassDefinition 
	
	^ anEPASTClassDefinition message acceptVisitor: self