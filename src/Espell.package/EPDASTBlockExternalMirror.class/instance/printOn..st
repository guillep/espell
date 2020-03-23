printing
printOn: aStream
	
	aStream
		nextPutAll: self class name;
		nextPutAll: ' (';
		nextPutAll: ([ self target object sourceCode asString ] on: Exception do: [ '(exception printing!)' ]);
		nextPutAll: ')'
	