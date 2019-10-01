accessing
innerBindingOf: aString
	| supclass |
	(self definesClassVariable: aString asSymbol)
		ifTrue: [ self haltIf: [ environment isNil ].
			^ EPClassVariableBinding new
				name: aString asSymbol
					ownerName: self name
					objectSpace: environment;
				yourself ].
	self flag: 'temporally commented'.
	self sharedPools do: [ :pool | (pool innerBindingOf: aString) ifNotNil: [ :binding | ^ binding ] ].
	supclass := self superclass.
	supclass isNilObject ifFalse: [  ^ supclass innerBindingOf: aString ].
	^ nil