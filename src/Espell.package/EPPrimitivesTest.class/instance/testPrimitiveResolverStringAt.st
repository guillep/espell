as yet unclassified
testPrimitiveResolverStringAt

	| result |
	result := primitiveResolver
		invokePrimitiveNumber: 63
		on: (objectSpace backend arrayClass instanceVariableAtIndex: 8)
		arguments: { objectSpace backend mirrorOn: 1 }.
	
	self assert: result basicClass equals: objectSpace backend characterClass.
	self assert: result asLocalLiteral equals: $A.