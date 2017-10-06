accessing
bindingOf: aName

	self associationsDo: [ :association | 
		(association instanceVariableAtIndex: 1) asLocalLiteral = aName
			ifTrue: [ ^ association ] ].
	^ nil