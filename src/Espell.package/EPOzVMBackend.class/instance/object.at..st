primitives
object: aMirror at: anIndex
	
	^ self primitives
				basicExecutePrimitive: 60
				onObject: aMirror
				withArguments: { anIndex }.