accessing
includesKey: aName

	self associationsDo: [ :association | 
		(association instanceVariableAtIndex: 1) asLocalLiteral = aName
			ifTrue: [ ^ true ] ].
	^ false