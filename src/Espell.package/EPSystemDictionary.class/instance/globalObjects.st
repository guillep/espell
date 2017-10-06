accessing
globalObjects
	
	"We get the real system dictionary"
	| globalsArray |
	systemDictionary := self internalSystemDictionary.
	
	"We get the internal array"
	globalsArray := systemDictionary instanceVariableAtIndex: 2.
	
	"We collect the values"
	^ (1 to: globalsArray size) collect: [ :i | globalsArray at: i ]