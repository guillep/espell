primitive-configuration
primitiveForNumber: aPrimitiveNumber
	^ self numberedPrimitives
		at: aPrimitiveNumber
		ifAbsent: [ ^EPNumberedPrimitive new number: aPrimitiveNumber; installOn: self; yourself. ]