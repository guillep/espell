primitives
object: theObjectNotMirror at: anIndex put: aValueObjectNotMirror
	
	self primitives
				basicExecutePrimitive: 61
				onObject: theObjectNotMirror
				withArguments: { anIndex . aValueObjectNotMirror }.