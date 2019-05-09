testing
includesClassNamed: aString 
	(aString = #PCUndefinedObject ) ifTrue: [ ^true ].
	^ self globalsDictionary includesKey: aString