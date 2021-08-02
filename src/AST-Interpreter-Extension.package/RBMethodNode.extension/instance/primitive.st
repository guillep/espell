*AST-Interpreter-Extension
primitive
	^ (self pragmas detect: [ :each | each isPrimitive ])
			arguments first value