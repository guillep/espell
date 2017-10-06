tests
testInterpreterDictionary

	| result |
	result := EPRemoteDictionary on: (interpreter evaluateCode: 'Dictionary new') environment: interpreter codeProvider.
	self assert: result size equals: 0.
	self assert: result basicClass name equals: 'Dictionary'.