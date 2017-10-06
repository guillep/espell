visitor
accept: anEPASTInterpreter assign: anEPMirror inNode: aRBVariableNode 
	
	^ (anEPASTInterpreter environment classNamed: ownerName)
			classPool at: name put: anEPMirror