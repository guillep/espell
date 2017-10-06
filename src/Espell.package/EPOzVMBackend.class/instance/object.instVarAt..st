primitives
object: anObjectNotMirror instVarAt: anIndex
	
	^ self primitives
				basicExecutePrimitive: 73
				onObject: anObjectNotMirror
				withArguments: { anIndex }.