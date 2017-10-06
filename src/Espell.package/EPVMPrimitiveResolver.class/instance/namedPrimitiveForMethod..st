primitive-configuration
namedPrimitiveForMethod: aMethod

	| primitivePragma module |
	primitivePragma := aMethod pragmas detect: #isPrimitive.
	module := self modules
		at: primitivePragma arguments second value
		ifAbsent: [ EPNamedPrimitiveModule new name: primitivePragma arguments second; yourself. ].
	^(module primitiveNamed: primitivePragma arguments first value)
		installOn: self;
		yourself