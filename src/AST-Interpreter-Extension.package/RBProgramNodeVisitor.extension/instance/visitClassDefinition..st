*AST-Interpreter-Extension
visitClassDefinition: anEPASTClassDefinition 
	
	^ anEPASTClassDefinition message acceptVisitor: self