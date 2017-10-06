primitives
floatObject: aMirror at: anIndex put: aValue
	
	^ (self
		executePrimitiveNumbered: 39
		on: aMirror
		withArguments: { self mirrorOn: anIndex . aValue }) asClassMirror