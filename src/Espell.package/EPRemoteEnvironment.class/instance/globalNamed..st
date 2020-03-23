accessing
globalNamed: aString 
	
	^ EPRemoteClass
		on: ("self globalsDictionary"mirror at: aString)
		environment: self