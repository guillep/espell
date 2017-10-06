tests
testSystemDictionaryNotEmpty

	| tally |
	tally := objectSpace backend systemDictionary instanceVariableAtIndex: 1.
	self assert: tally isSmallInteger.
	self assert: tally target > 0