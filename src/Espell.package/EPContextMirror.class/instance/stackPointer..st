accessing
stackPointer: anInteger
	self instanceVariableAtIndex: (self backend instanceVariableMapping contextStackpIndex) put: (backend smallIntegerMirrorOn: anInteger)