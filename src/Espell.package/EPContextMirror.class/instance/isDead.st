testing
isDead
	^ (self instanceVariableAtIndex: (self backend instanceVariableMapping contextPcIndex)) isNilObject