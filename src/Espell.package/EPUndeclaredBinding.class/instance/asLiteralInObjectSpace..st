converting
asLiteralInObjectSpace: anObjectSpace
	"If we did not find a binding for the given global, it means that the global is not declared in the bootstrap.
	1) We then create an undeclared in the undeclared dictionary
	2) We return the new binding"
	^ objectSpace bootstrapInterpreter
			evaluateCode: 'Undeclared at: undeclaredName put: nil.
								Undeclared associationAt: undeclaredName'
			withTemps: { 
				'undeclaredName' -> (name asSymbol asLiteralInObjectSpace: anObjectSpace)
			}.