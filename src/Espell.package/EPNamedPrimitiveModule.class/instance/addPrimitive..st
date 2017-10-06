primitive-accessing
addPrimitive: aPrimitive 

	aPrimitive module: self.
	primitives at: aPrimitive name put: aPrimitive.
	^ aPrimitive