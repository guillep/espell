builders
newMethodWithBytecodeSize: bytecodeSize withHeader: aMethodHeader

	^ (backend 
					newMethodOfClass: self methodClass target
					withBytecodeSize: bytecodeSize
					withHeader: (aMethodHeader asLiteralInObjectSpace: self) target)