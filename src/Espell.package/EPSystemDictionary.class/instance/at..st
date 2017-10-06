testing
at: aString 
	
	cache at: aString ifPresent: [ :global | ^global ].
	^ objectSpace interpreter
			evaluateCode: 'systemDictionary at: key'
			withTemps: {
				'systemDictionary' -> systemDictionary.
				'key' -> (aString asSymbol asLiteralInObjectSpace: objectSpace) }