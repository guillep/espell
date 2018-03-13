accessing
classPool: aClassPool
	
	"We wish this is a class where this fits"
	^ self instanceVariableAtIndex: (self backend instanceVariableMapping classPoolIndex) put: aClassPool