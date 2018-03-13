accessing
methodDictionary: aDictionary
	^ self instanceVariableAtIndex: (self backend instanceVariableMapping classMethodDictionaryIndex) put: aDictionary