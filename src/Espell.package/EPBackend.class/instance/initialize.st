initialize-release
initialize

	super initialize.
	
	byteSymbolMapping := EPByteSymbolMapping new objectSpace: self; yourself.
	largeNegativeIntegerMapping := EPLargeNegativeIntegerMapping new objectSpace: self; yourself.
	largePositiveIntegerMapping := EPLargePositiveIntegerMapping new objectSpace: self; yourself.