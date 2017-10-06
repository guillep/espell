as yet unclassified
testPrimitiveResolverStringAtPut

	| string |
	string := 'a' asLiteralInObjectSpace: objectSpace backend.
	primitiveResolver
		invokePrimitiveNumber: 64
		on: string
		arguments: { objectSpace backend mirrorOn: 1 . $A asLiteralInObjectSpace: objectSpace backend }.
	
	self assert: string asLocalLiteral equals: 'A'.