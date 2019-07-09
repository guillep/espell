special objects
systemDictionary: anEPSystemDictionary

	"The Smalltalk instance in most special objects arrays.
	Smalltalk specialObjectsArray indexOf: Smalltalk"
	self flag: 'commented PharoCandle'.
	
	^ systemDictionary := anEPSystemDictionary "(self  specialObjectsArray at: 8) asClassMirror basicNew: 1." 
	 "self smalltalkInstance instanceVariableAtIndex: (self instanceVariableMapping smalltalkImageGlobalsIndex)".