iterating
size
	
	| firstIndex lastIndex |
	firstIndex := (mirror instanceVariableAtIndex: 2) asSmallInteger.
	lastIndex := (mirror instanceVariableAtIndex: 3) asSmallInteger.
	^ lastIndex - firstIndex