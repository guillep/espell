initialize-release
initialize
	super initialize.
	numberedPrimitives := Dictionary new.
	modules := Dictionary new.
	
	"SmallInteger primitives"
	3 to: 12 do: [ :primitiveNumber |
		(EPNumberedPrimitive new number: primitiveNumber) 
			transformResultToRemoteLiteral 
			installOn: self.
	].

	"Float primitives"
	38 to: 39 do: [ :primitiveNumber |
		(EPNumberedPrimitive new number: primitiveNumber) 
			transformArgumentsToRemoteLiteral
			transformResultToRemoteLiteral 
			installOn: self.
	].
	41 to: 50 do: [ :primitiveNumber |
		(EPNumberedPrimitive new number: primitiveNumber) 
			transformArgumentsToRemoteLiteral
			transformResultToRemoteLiteral 
			installOn: self.
	].

	"byteString/byteSymbol at:"
	(EPNumberedPrimitive new number: 63) 
		transformResultToRemoteLiteral 
		installOn: self.
		
	"byteString/byteSymbol at:put:"
	(EPNumberedPrimitive new number: 64) 
		transformArgumentsToRemoteLiteral
		installOn: self.
	
	"WriteStream nextPut:"
	((EPNumberedPrimitive new number: 66)
		transformArgumentsToRemoteLiteral
		transformResultToRemoteLiteral)
		installOn: self.
		
	"basicNew"
	(EPNewObjectInitializationPrimitiveDecorator
		decorate: (EPNumberedPrimitive new number: 70))
		installOn: self.
	(EPNewObjectInitializationPrimitiveDecorator
		decorate: (EPNumberedPrimitive new number: 71))
		installOn: self.
	
	(EPSemaphoreAdapterPrimitiveDecorator
		decorate: (EPNumberedPrimitive new number: 85))
		installOn: self.

	"=="
	(EPNumberedPrimitive new number: 110)
			transformResultToRemoteLiteral
			installOn: self.
	
	"get class"
	(EPNumberedPrimitive new number: 111)
			transformResultToRemoteClass
			installOn: self.
			
	"pointsTo:"
	(EPNumberedPrimitive new number: 132)
		transformResultToRemoteLiteral
		installOn: self.
	
	"primUTCMicrosecondsClock"
	(EPNumberedPrimitive new number: 240)
			transformResultToRemoteLiteral
			installOn: self.
	
	"isNil"
	257 to: 258 do: [ :primitiveNumber |
		(EPNumberedPrimitive new number: primitiveNumber)
			transformResultToRemoteLiteral
			installOn: self.
	].

	"Byte objects hash"
	((EPNamedPrimitiveModule new
		name: 'MiscPrimitivePlugin')
		addPrimitive: (EPNamedPrimitive new
			name:'primitiveStringHash')
			transformResultToRemoteLiteral)
			installOn: self.

	"*"
	((EPNamedPrimitiveModule new
		name: 'LargeIntegers')
		addPrimitive: (EPNamedPrimitive new
			name:'primDigitMultiplyNegative')
			transformResultToRemoteLiteral)
			installOn: self.