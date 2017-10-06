well known primitives
basicNewOn: aClassHandle withSize: aSizeObjectMirror

	^ self
		invokePrimitiveNumber: 71
		on: aClassHandle
		arguments: { aSizeObjectMirror }