accessing
basicSetClassName: aClassNameMirror 
	
	^ self instanceVariableAtIndex: (self backend instanceVariableMapping classNameIndex) put: aClassNameMirror