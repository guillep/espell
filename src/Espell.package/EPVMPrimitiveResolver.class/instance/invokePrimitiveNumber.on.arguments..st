execution
invokePrimitiveNumber: aNumber on: receiver arguments: arguments

	^ ((self primitiveForNumber: aNumber)
				executionWithReceiver: receiver
				andArguments: arguments)
					execute
