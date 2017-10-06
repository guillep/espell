as yet unclassified
get: aPrimitive 

	^ self methods
		detect: [ :m | m pragmas anySatisfy: [ :p | p arguments first = aPrimitive ] ]
		ifNone: [ self error: 'Primitive not found: ', aPrimitive ]