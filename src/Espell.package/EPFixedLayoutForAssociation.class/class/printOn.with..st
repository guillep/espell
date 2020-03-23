printing
printOn: aStream with: aMirror
	aStream
		nextPutAll: (aMirror instanceVariableAtIndex: 1) asString;
		nextPutAll: ' -> ';
		nextPutAll: (aMirror instanceVariableAtIndex: 2) asString