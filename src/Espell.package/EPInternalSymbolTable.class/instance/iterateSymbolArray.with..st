private-iterating
iterateSymbolArray: anArray with: aBlock

	| array |
	array := anArray.
	1 to: array size do: [ :i | | element |
		element := array at: i.
		aBlock value: element.
	]