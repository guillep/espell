testing
size
	
	^ (objectSpace interpreter
			evaluateCode: 'systemDictionary size'
			withTemps: { 'systemDictionary' -> systemDictionary }) asSmallInteger