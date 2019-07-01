gt-inspector-extension
printOn: aStream
	aStream nextPutAll: 'EPMirror (a ', self basicClass classNameFromAnyOrigin asString, ')'