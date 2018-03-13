accessing
stackPointer
	^(self instanceVariableAtIndex: (self backend instanceVariableMapping contextStackpIndex)) target