primitives
contextSizeOf: aMirror

	^ self
		handle: aMirror target
		executePrimitive: 212
		withArgs: #().