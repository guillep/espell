as yet unclassified
createCompiledMethodWithSize: bytecodeSize andHeader: methodHeader 
	
	"self objectMemory instantiateCompiledMethodClass: self methodClass target address indexableSize: bytecodeSize"
	
	^ (self
		executePrimitiveNumber: 79
		on: self methodClass
		withArguments: { self smallIntegerMirrorOn: bytecodeSize . self smallIntegerMirrorOn: methodHeader })
			value asMethodMirror