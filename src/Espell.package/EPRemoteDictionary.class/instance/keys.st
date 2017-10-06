accessing
keys

	| keys |
	keys := OrderedCollection new.
	self associationsDo: [ :association | 
		keys add: (association instanceVariableAtIndex: 1) asLocalLiteral ].
	^ keys