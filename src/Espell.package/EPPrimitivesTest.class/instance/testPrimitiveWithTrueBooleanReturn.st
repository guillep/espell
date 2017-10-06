tests
testPrimitiveWithTrueBooleanReturn

	"(SmallInteger >> #<) primitive"
	
	| primitive result |
	primitive := ((EPNumberedPrimitive new number: 3)
		resolver: primitiveResolver)
			transformResultToRemoteLiteral
			resolver: primitiveResolver;
			yourself.
	result := (primitive
		executionWithReceiver: (objectSpace backend mirrorOn:1)
		andArguments: {(objectSpace backend mirrorOn:2)}) execute.
		
	self assert: result equals: objectSpace backend trueObject.