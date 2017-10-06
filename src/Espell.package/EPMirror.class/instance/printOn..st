printing
printOn: aStream
	aStream
		nextPutAll: self class name;
		nextPutAll: '(';
		nextPutAll: self identityHash asString;
		nextPutAll: ')'