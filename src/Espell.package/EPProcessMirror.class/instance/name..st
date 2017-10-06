accessing
name: aString
	
	self 
		instanceVariableAtIndex: 5 
		put: (aString asLiteralInObjectSpace: self backend)