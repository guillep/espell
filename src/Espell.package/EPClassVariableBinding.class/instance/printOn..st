literal resolution
printOn: aStream

	aStream
		nextPutAll: ownerName;
		nextPutAll: ' => ';
		nextPutAll: name.