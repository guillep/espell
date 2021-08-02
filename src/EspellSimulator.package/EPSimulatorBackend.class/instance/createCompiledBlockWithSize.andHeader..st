as yet unclassified
createCompiledBlockWithSize: bytecodeSize andHeader: methodHeader 
	
	"self objectMemory instantiateCompiledMethodClass: self methodClass target address indexableSize: bytecodeSize"
	
	^ (self
		executePrimitiveNumber: 79
		on: self compiledBlockClass
		withArguments: { self smallIntegerMirrorOn: bytecodeSize . self smallIntegerMirrorOn: methodHeader })
			value asMethodMirror