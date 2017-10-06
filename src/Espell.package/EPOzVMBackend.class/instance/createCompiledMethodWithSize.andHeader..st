primitives
createCompiledMethodWithSize: bytecodeSize andHeader: methodHeader 
	

	^ (self
		executePrimitiveNumbered: 79
		on: self methodClass
		withArguments: { self mirrorOn: bytecodeSize . self mirrorOn: methodHeader })
		markExperimentalBit: true;
		asMethodMirror