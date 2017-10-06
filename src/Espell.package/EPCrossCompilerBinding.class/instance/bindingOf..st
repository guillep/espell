binding-accessing
bindingOf: aString

	(class classVarNames includes: aString asSymbol)
		ifTrue: [ self assert: environment notNil.
			^ EPClassVariableBinding new
				name: aString asSymbol
					ownerName: class theNonMetaClass name
					objectSpace: environment;
				yourself ].
	class sharedPools
		do: [ :pool | 
			((self newBindingFor: pool) bindingOf: aString)
				ifNotNil: [ :binding | ^ binding ] ].
	class superclass
		ifNotNil: [ (self superclassBinding bindingOf: aString)
				ifNotNil: [ :binding | ^ binding ] ].
	(environment includesClassNamed: aString)
		ifTrue: [ self assert: environment notNil.
			^ EPGlobalBinding new
				name: aString objectSpace: environment;
				yourself ].

	"If it is a temp or an instance variable"
	^ nil