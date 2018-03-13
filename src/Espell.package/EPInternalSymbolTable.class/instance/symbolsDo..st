public
symbolsDo: aBlock

	| symbolClass symbolClassPools arrayClass |
	arrayClass := objectSpace backend arrayClass.
	symbolClass := objectSpace backend symbolTableClass asClassMirror.
	symbolClassPools := symbolClass classPool instanceVariableAtIndex: (self instanceVariableMapping dictionaryArrayIndex).
	1 to: symbolClassPools size do: [ :i | | associationOrNil |
		associationOrNil := symbolClassPools at: i.
		associationOrNil isNilObject ifFalse: [ | symbolSet |
			symbolSet := associationOrNil instanceVariableAtIndex: 2.
			symbolSet isNilObject ifFalse: [
				symbolSet basicClass = arrayClass
					ifTrue: [ self iterateSymbolArray: symbolSet with: aBlock ]
					ifFalse: [ self iterateSymbolWeakSet: symbolSet with: aBlock] ] ].
	].