public
toInternalCharacterTable

	| internal  remoteTable |
	internal := EPInternalCharacterTable new objectSpace: objectSpace.
	
	remoteTable := objectSpace newArrayWithAll: (Character characterTable collect: [ :each | each asLiteralInObjectSpace: objectSpace ]).
	internal setCharacterTable: remoteTable.
	objectSpace characterTable: internal.