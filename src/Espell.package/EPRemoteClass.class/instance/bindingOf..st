binding
bindingOf: aString
	(self definesClassVariable: aString asSymbol)
		ifTrue: [ self haltIf: [ environment isNil ].
			^ EPClassVariableBinding new
				name: aString asSymbol
					ownerName: self name
					objectSpace: environment;
				yourself ].
	self sharedPools
		do:
			[ :pool | self halt: 'implement' . (pool bindingOf: aString) ifNotNilDo: [ :binding | ^ binding ] ].
	(self superclass bindingOf: aString)
		ifNotNil: [ :binding | ^ binding ].
	
	(self definesClassVariable: aString asSymbol)
		ifTrue: [ self haltIf: [ environment isNil ].
			^ EPGlobalBinding new
				name: aString objectSpace: environment;
				yourself ].

	^ nil 