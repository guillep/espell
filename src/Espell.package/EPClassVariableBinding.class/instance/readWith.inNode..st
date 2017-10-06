accessing
readWith: anEPASTInterpreter inNode: aRBVariableNode 
	
	^ (anEPASTInterpreter environment classNamed: ownerName)
			classPool at: name