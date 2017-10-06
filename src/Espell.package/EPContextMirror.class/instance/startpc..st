accessing
startpc: anInteger
	self instanceVariableAtIndex: 2 put: (backend smallIntegerMirrorOn: anInteger)