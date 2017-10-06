testing
includesGlobalNamed: aString 
	
	cache at: aString ifPresent: [ :global | ^ true ].
	^ (objectSpace interpreter
		evaluateCode: 'systemDictionary includesKey: key'
		withTemps: { 
			'systemDictionary' -> systemDictionary.
			'key' -> (aString asSymbol asLiteralInObjectSpace: objectSpace) })
			asBoolean