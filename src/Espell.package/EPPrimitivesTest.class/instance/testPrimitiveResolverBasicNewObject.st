tests
testPrimitiveResolverBasicNewObject

	| result |
	result := primitiveResolver
		invokePrimitiveNumber: 71
		on: (objectSpace backend arrayClass)
		arguments: { objectSpace backend mirrorOn: 2 }.
	
	self assert: result basicClass equals: objectSpace backend arrayClass.
	self assert: (result at: 1) isNilObject.
	self assert: (result at: 2) isNilObject