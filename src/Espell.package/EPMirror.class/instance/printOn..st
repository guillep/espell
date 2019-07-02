gt-inspector-extension
printOn: aStream
	aStream nextPutAll: self class name asString, ' (a ', self basicClass classNameFromAnyOrigin asString, ')'