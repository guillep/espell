execution
basicExecutePrimitive: aPrimitiveNumber onObject: anObject withArguments: anArrayOfArguments
	| result |
	result := backend mirrorOn: ((ProtoObject >> #tryPrimitive:withArgs:)
		executeOn: anObject withArguments: { aPrimitiveNumber . anArrayOfArguments }).
	
	(self hasPrimitiveFailed: result) ifTrue: [ self primitiveFailed ].
	^result