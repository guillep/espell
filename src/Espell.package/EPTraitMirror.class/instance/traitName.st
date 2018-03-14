accessing
traitName
	
	^ backend fromRemoteByteSymbol: (self instanceVariableAtIndex: (self backend instanceVariableMapping traitNameIndex))