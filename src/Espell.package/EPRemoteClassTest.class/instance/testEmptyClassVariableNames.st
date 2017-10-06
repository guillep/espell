tests
testEmptyClassVariableNames

	| remoteClass |
	remoteClass := environment classNamed: #ProtoObject.
	self assert: remoteClass classVariableNames equals: ProtoObject classVarNames.