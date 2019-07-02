accessing
associationsDo: aBlock

	| array |
	array := mirror "instanceVariableAtIndex: (mirror instanceVariableMapping dictionaryArrayIndex)".
	^ (1 to: array size)
		select: [ :i | (array at: i) isNilObject not ]
		thenDo: [ :i | | association |
			association := array at: i.
			aBlock value: association  ]