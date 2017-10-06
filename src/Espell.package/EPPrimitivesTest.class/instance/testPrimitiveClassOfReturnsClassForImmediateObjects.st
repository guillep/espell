tests
testPrimitiveClassOfReturnsClassForImmediateObjects

	"(SmallInteger >> #>) primitive"
	
	| primitive result |
	primitive := ((EPNumberedPrimitive new number: 111)
		resolver: primitiveResolver)
			transformResultToRemoteClass
			resolver: primitiveResolver;
			yourself.
	result := (primitive executionWithReceiver: (objectSpace backend mirrorOn:1) andArguments: #()) execute.

	self assert: result equals: objectSpace backend smallIntegerClass