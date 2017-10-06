accessing
stackPointer: anInteger
	self instanceVariableAtIndex: 3 put: (backend smallIntegerMirrorOn: anInteger)