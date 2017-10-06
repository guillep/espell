primitives
classOf: anObjectMirror

	^ (self
		executePrimitiveNumbered: 111
		on: anObjectMirror
		withArguments: #()) asClassMirror