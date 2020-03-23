testing
includesClassNamed: aString 
	self flag: 'remove hardcoded references to UndefinedObject'.
	(aString = #PCUndefinedObject or: [ aString = #UndefinedObject ] ) ifTrue: [ ^true ].
	^ self globalsDictionary includesKey: aString