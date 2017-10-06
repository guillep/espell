primitives
executePrimitiveMethod: aMethod on: aMirror withArguments: aCollection 
	self halt: 'should return an EPPrimitiveResult'.
	^ self primitives
				invokePrimitiveMethod: aMethod
				on: aMirror
				arguments: aCollection.