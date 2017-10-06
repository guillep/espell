tests
testInterpreterPrimitiveAdd

	| result |
	result := interpreter evaluateCode: '1+2'.
	self assert: result isSmallInteger.
	self assert: result target equals: 3.