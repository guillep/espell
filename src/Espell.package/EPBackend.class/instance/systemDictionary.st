special objects
systemDictionary

	"The Smalltalk instance in most special objects arrays.
	Smalltalk specialObjectsArray indexOf: Smalltalk"

	^ "systemDictionary" "(self  specialObjectsArray at: 8) asClassMirror basicNew: 1." 
	 [self smalltalkInstance instanceVariableAtIndex: (self instanceVariableMapping smalltalkImageGlobalsIndex)] on: Exception do: [ systemDictionary ].