initialize-release
initialize

	super initialize.
	compactClasses := EPDictionary new.
	
	symbolTable := EPInternalSymbolTable new objectSpace: self; yourself.
	primitives := EPVMPrimitiveResolver new backend: self; yourself.
	
	byteStringMapping := EPByteStringMapping new objectSpace: self; yourself.
	byteArrayMapping := EPByteArrayMapping new objectSpace: self; yourself.
	compiledMethodMapping := EPMethodMapping new objectSpace: self; yourself.
	largeNegativeIntegerMapping := EPLargeNegativeIntegerMapping new objectSpace: self; yourself.
	largePositiveIntegerMapping := EPLargePositiveIntegerMapping new objectSpace: self; yourself.