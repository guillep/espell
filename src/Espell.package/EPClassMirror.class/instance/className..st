accessing
className: aString 
	
	^ self instanceVariableAtIndex: (self backend instanceVariableMapping classNameIndex) put: (aString asLiteralInObjectSpace: self backend)