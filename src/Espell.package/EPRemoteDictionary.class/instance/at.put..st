accessing
at: aName put: aValue

	self associationsDo: [ :association | 
		(association instanceVariableAtIndex: 1) asLocalLiteral = aName
			ifTrue: [ ^ association instanceVariableAtIndex: 2 put: aValue ] ].
	^ KeyNotFound signalFor: aName in: self