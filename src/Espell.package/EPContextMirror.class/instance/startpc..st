accessing
startpc: anInteger
	self instanceVariableAtIndex: (self backend instanceVariableMapping contextPcIndex) put: (backend smallIntegerMirrorOn: anInteger)