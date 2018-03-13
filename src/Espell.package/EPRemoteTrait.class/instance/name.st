accessing
name

	^ mirror  backend fromRemoteByteSymbol: (mirror instanceVariableAtIndex: (self instanceVariableMapping traitNameIndex))