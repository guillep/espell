accessing
globalNamed: aString 
	
	^ EPRemoteClass
		on: (self globalsDictionary at: aString)
		environment: self