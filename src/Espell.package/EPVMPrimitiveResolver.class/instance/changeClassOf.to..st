well known primitives
changeClassOf: anObjectMirror to: aClassMirror

	self
		basicExecutePrimitive: 160
		onObject: aClassMirror target
		withArguments: { anObjectMirror target }.