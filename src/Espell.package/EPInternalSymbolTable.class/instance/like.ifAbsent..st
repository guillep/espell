public
like: aString ifAbsent: aBlock

	| symbolClass symbolClassPools arrayClass |
	arrayClass := objectSpace backend arrayClass.
	symbolClass := objectSpace backend symbolTableClass asClassMirror.
	symbolClassPools := symbolClass classPool instanceVariableAtIndex: (objectSpace backend instanceVariableMapping dictionaryArrayIndex).
	1 to: symbolClassPools size do: [ :i | | associationOrNil |
		associationOrNil := symbolClassPools at: i.
		associationOrNil isNilObject ifFalse: [ | symbolSet |
			symbolSet := associationOrNil instanceVariableAtIndex: 2.
			symbolSet isNilObject ifFalse: [
				symbolSet basicClass = arrayClass
					ifTrue: [ 
						self
							iterateSymbolArray: symbolSet
							with:  [ :remoteSymbol | remoteSymbol asLocalString = aString ifTrue: [ ^ remoteSymbol ] ]. ]
					ifFalse: [ 
						| found |
						found := (EPRemoteWeakSet on: symbolSet) like: aString ifAbsent: [ nil ].
						found ifNotNil: [ ^ found ]]
					] ] ].
		^ aBlock value