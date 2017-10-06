well known primitives
classOf: anObjectHandle
	
	^ self
		invokePrimitiveNumber: 111
		on: anObjectHandle
		arguments: {  }