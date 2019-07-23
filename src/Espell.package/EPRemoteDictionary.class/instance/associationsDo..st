accessing
associationsDo: aBlock

	| array |
	array := mirror instanceVariableAtIndex: (mirror instanceVariableMapping dictionaryArrayIndex).
	^ (1 to: array size)
		select: [ :i | (array uncheckedAt: i) isNilObject not ]
		thenDo: [ :i | | association |
			association := array uncheckedAt: i.
			aBlock value: association  ]