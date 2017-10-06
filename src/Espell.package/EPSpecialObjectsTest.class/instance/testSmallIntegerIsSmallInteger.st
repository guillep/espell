tests
testSmallIntegerIsSmallInteger

	self assert: (objectSpace backend mirrorOn: 2) isSmallInteger.