tests
testSpecialObjectsArrayIsArray

	self
		assert: objectSpace backend specialObjectsArray basicClass
		equals: objectSpace backend arrayClass