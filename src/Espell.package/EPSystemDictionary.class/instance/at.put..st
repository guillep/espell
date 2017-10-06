testing
at: aString put: aValue
	
	cache at: aString put: aValue.
	
	^ objectSpace interpreter
			evaluateCode: 'systemDictionary at: key put: aValue'
			withTemps: { 
				'systemDictionary' -> systemDictionary.
				'key' -> (aString asSymbol asLiteralInObjectSpace: objectSpace).
				'aValue' -> aValue }