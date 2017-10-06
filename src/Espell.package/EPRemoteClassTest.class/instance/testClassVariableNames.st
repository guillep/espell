tests
testClassVariableNames

	| remoteClass |
	remoteClass := environment classNamed: #Object.
	self assert: remoteClass classVariableNames equals: Object classVarNames.