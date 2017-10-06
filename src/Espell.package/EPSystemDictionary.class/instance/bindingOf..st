binding
bindingOf: aName

	^ objectSpace interpreter
		evaluateCode: 'systemDictionary bindingOf: key'
		withTemps: { 
			'systemDictionary' -> systemDictionary.
			'key' -> (aName asSymbol asLiteralInObjectSpace: objectSpace) }