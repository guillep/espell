evaluating
initializeWithCode: code withTemps: aCollection 
	^ self newInterpreter 
		initializeWithProgram: (RBParser parseExpression: code) 
		withTemps: aCollection 
		astCache: astCache