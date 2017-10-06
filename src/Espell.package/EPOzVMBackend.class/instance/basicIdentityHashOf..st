primitives
basicIdentityHashOf: anObject

	| result |
	result := self
		handle: anObject target
		executePrimitive: 75.
	^ self mirrorOn: result