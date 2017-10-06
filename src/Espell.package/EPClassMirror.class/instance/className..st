accessing
className: aString 
	
	^ self instanceVariableAtIndex: 8 put: (aString asLiteralInObjectSpace: self backend)