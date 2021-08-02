lookup
lookupVar: aName declare: aBoolean

	self allSlots detect: [ :e | e name = aName ] ifFound: [ :e | ^ e ].

	Smalltalk globals reservedVariables at: aName ifPresent: [ :e | ^e ].
	
	(self innerBindingOf: aName) ifNotNil: [ :e | ^ e ].

	^ environment bindingOf: aName