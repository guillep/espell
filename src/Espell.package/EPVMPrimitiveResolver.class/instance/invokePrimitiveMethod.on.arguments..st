execution
invokePrimitiveMethod: aCompiledMethod on: receiver arguments: arguments
	^ aCompiledMethod isNamedPrimitive
		ifTrue: [ ((self namedPrimitiveForMethod: aCompiledMethod)
							executionWithReceiver: receiver
							andArguments: arguments) execute ]
		ifFalse: [ ((self primitiveForNumber: aCompiledMethod primitive)
							executionWithReceiver: receiver
							andArguments: arguments) execute ]