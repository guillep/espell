primitive-accessing
primitiveNamed: aPrimitiveName

	^ primitives
		at: aPrimitiveName
		ifAbsent: [ self addPrimitive: (EPNamedPrimitive new name: aPrimitiveName) ]