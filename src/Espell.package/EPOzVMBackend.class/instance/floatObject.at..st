primitives
floatObject: aMirror at: anIndex
	
	^ (self
		executePrimitiveNumbered: 38
		on: aMirror
		withArguments: { self mirrorOn: anIndex }) asClassMirror