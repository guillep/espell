accessing
globalObjects
	
	"We get the real system dictionary"
	| globalsArray |
	systemDictionary := self internalSystemDictionary.
	
	"We get the internal array"
	globalsArray := systemDictionary instanceVariableAtIndex: (self instanceVariableMapping dictionaryArrayIndex).
	
	"We collect the values"
	^ (1 to: globalsArray size) collect: [ :i | globalsArray at: i ]