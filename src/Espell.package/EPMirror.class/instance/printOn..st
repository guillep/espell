gt-inspector-extension
printOn: aStream
	self basicClass layout printOn: aStream with: self
	"aStream nextPutAll: self class name asString, ' (a ', self basicClass classNameFromAnyOrigin asString, ')'"