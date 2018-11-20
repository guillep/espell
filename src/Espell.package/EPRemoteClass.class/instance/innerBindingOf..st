binding
innerBindingOf: aString
	(self definesClassVariable: aString asSymbol)
		ifTrue: [ self haltIf: [ environment isNil ].
			^ EPClassVariableBinding new
				name: aString asSymbol
					ownerName: self name
					objectSpace: environment;
				yourself ].
	self sharedPools
		do:
			[ :pool | (pool bindingOf: aString) ifNotNilDo: [ :binding | ^ binding ] ].
	(self superclass bindingOf: aString)
		ifNotNil: [ :binding | ^ binding ].
	"If it is a temp or an instance variable"
	^ nil