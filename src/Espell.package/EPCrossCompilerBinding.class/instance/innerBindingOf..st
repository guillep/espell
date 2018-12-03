binding-accessing
innerBindingOf: aString

	(class classVarNames includes: aString asSymbol)
		ifTrue: [ self assert: environment notNil.
			^ EPClassVariableBinding new
				name: aString asSymbol
					ownerName: class theNonMetaClass name
					objectSpace: environment;
				yourself ].
	class instanceSide sharedPools
		do: [ :pool | 
			((self newBindingFor: pool) innerBindingOf: aString)
				ifNotNil: [ :binding | ^ binding ] ].
	class superclass
		ifNotNil: [ (self superclassBinding innerBindingOf: aString)
				ifNotNil: [ :binding | ^ binding ] ].

	"If it is a temp or an instance variable"
	^ nil