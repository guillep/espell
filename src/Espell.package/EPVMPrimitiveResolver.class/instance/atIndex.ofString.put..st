well known primitives
atIndex: anIndexMirror ofString: aStringMirror put: aCharacterMirror
	
	^ self
		invokePrimitiveNumber: 64
		on: aStringMirror target
		arguments: { anIndexMirror target . aCharacterMirror asLocalLiteral }