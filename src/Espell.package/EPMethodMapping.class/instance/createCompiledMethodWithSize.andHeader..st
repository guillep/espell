transformations
createCompiledMethodWithSize: bytecodeSize andHeader: aMethodHeader
	
	^ self objectSpace backend methodMirrorOn: 
		(self objectSpace backend
				createCompiledMethodWithSize: bytecodeSize
				andHeader: (aMethodHeader asLiteralInObjectSpace: self objectSpace))