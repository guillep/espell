gt-inspector-extension
printOn: aStream
	aStream nextPutAll: 'EPClassMirror (', self classNameFromAnyOrigin asString, ')'