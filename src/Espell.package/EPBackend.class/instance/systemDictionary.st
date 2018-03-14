special objects
systemDictionary

	"The Smalltalk instance in most special objects arrays.
	Smalltalk specialObjectsArray indexOf: Smalltalk"
	^ self smalltalkInstance instanceVariableAtIndex: (self instanceVariableMapping smalltalkImageGlobalsIndex).