primitives
executePrimitiveNumbered: aNumber on: aMirror withArguments: aCollection 
	
	^ self primitives
				invokePrimitiveNumber: aNumber
				on: aMirror
				arguments: aCollection.