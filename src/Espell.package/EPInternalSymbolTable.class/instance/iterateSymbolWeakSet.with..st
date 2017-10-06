private-iterating
iterateSymbolWeakSet: aWeakSet with: aBlock
	| array flag |
	array := aWeakSet instanceVariableAtIndex: 2.
	flag := aWeakSet instanceVariableAtIndex: 3.
	1 to: array size do: [ :i | 
		| element |
		element := array at: i.
		(nil ~~ element target and: [ element isNilObject not and: [ element ~= flag ] ])
			ifTrue: [ aBlock value: element ] ]