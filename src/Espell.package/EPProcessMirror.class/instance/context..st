accessing
context: aContextMirror
	self 
		instanceVariableAtIndex: (self backend instanceVariableMapping processContextIndex)
		put: aContextMirror