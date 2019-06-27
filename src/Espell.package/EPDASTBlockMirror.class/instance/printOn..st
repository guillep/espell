printing
printOn: aStream
	
	aStream
		nextPutAll: self class name;
		nextPutAll: '(';
		nextPutAll: ([ self target object asString ] on: Exception do: [ '(exception printing!)' ]);
		nextPutAll: ')'
	