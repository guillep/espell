literal resolution
asLiteralInEnvironment: anEnvironment
	^ binding
		ifNil: [ 
			| currentClass |
			currentClass := anEnvironment classNamed: ownerName.
			[ currentClass isNilObject ]
				whileFalse: [ 
					(currentClass includesClassVariableNamed: self name)
						ifTrue: [ ^ binding := currentClass classPool basicBindingOf: self name ].
					currentClass := currentClass superclass ].
			self error: ('Variable {1} not defined' format: {(self printString)}) ]