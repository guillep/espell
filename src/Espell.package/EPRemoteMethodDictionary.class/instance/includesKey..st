accessing
includesKey: aString 
	
	1 to: mirror size do: [ :index | | key |
		key := mirror at: index.
		key isNilObject ifFalse: [ key asLocalString = aString ifTrue: [ ^ true ] ] ].
	^ false