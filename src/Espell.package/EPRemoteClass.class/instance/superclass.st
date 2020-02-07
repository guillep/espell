accessing
superclass
	| superclmirror |
	
	superclmirror := mirror superclass.
	
	superclmirror isNilObject 
		ifTrue: [ | sclassname |
			sclassname := mirror asRGClass superclass 
				ifNil: [ ^ mirror backend nilObject ]
				ifNotNil: [ :rgsclass | rgsclass name ].
			 
			superclmirror := mirror builder classLoader classNamed: sclassname ]
		ifFalse: [ mirror superclass ].
	superclmirror isNilObject ifTrue: [ ^ mirror backend nilObject ].
	^ (EPRemoteClass on: superclmirror environment: environment) 