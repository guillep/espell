accessing
innerBindingOf: aString
	
	(self definesClassVariable: aString asSymbol)
		ifTrue: [ self haltIf: [ environment isNil ].
			^ EPClassVariableBinding new
				name: aString asSymbol
					ownerName: self name
					objectSpace: environment;
				yourself ].
	self sharedPools do: [ :pool | self halt. (pool bindingOf: aString) ifNotNilDo: [ :binding | ^ binding ] ].
	self superclass ifNotNil: [  :supercl | ^ supercl innerBindingOf: aString ].
	^ nil