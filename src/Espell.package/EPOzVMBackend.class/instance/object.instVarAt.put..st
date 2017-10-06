primitives
object: anObjectNotMirror instVarAt: anIndex put: aValueObjectNotMirror
	
	self primitives
				basicExecutePrimitive: 74
				onObject: anObjectNotMirror
				withArguments: { anIndex . aValueObjectNotMirror }.