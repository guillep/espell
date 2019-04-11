binding
innerBindingOf: aString
	(self definesClassVariable: aString asSymbol)
		ifTrue: [ self haltIf: [ environment isNil ].
			^ EPClassVariableBinding new
				name: aString asSymbol
					ownerName: self name
					objectSpace: environment;
				yourself ].

	
"	self sharedPools
		do:
			[ :pool | (pool innerBindingOf: aString) ifNotNil: [ :binding | ^ binding ] ]."

	self superclass ifNotNil:[	
		(self superclass innerBindingOf: aString)
			ifNotNil: [ :binding | ^ binding ]].

	^ nil