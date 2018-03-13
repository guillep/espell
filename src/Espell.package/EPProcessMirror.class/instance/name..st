accessing
name: aString
	
	self 
		instanceVariableAtIndex: (self backend instanceVariableMapping processNameIndex) 
		put: (aString asLiteralInObjectSpace: self backend)