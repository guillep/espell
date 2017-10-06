tests
testAtSymbolIsCachedFromLoadTime

	self assert: (objectSpace backend symbolTable includesCachedKey: #at:).