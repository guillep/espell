accessing
at: aName

	self associationsDo: [ :association | 
		(association instanceVariableAtIndex: 1) asLocalLiteral = aName
			ifTrue: [ ^ association instanceVariableAtIndex: 2 ] ].
	^ KeyNotFound signalFor: aName in: self