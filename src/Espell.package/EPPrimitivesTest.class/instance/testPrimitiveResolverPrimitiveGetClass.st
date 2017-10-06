tests
testPrimitiveResolverPrimitiveGetClass

	| result |
	result := primitiveResolver
		invokePrimitiveNumber: 111
		on: (objectSpace backend mirrorOn:1)
		arguments: #().
	self assert: result equals: objectSpace backend smallIntegerClass