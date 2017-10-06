transformations
createCompiledMethodWithSize: bytecodeSize andHeader: aMethodHeader
	
	self objectSpace methodMirrorOn: 
		(self objectSpace 
				newMethodOfClass: self objectSpace methodClass
				withBytecodeSize: bytecodeSize
				withHeader: (aMethodHeader asLiteralInObjectSpace: self objectSpace))