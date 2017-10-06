interpreting
newInterpreter
	| newInterpreter |
	newInterpreter := interpreterClass new.
	newInterpreter initializeWithEvaluator: self.
	newInterpreter astCache: astCache.
	^newInterpreter.