accessing
initializeTemporaryVariables

	"This will push in the context's stack a nil for each of the temporary variables of the method. Both the primitive and the code that follows are in theory doing the same."
	self primitiveInitializeTempsInStack.
	1 to: self method numberOfTemps do: [ :i |
		self tempAt: i put: backend nilObject.
	].