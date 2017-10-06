tests
testSystemDictionaryIsSystemDictionary

	self assert: objectSpace backend systemDictionary basicClass className equals: 'SystemDictionary'