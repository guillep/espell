tests
testInstanceVariableNames

	| remoteClass |
	remoteClass := environment classNamed: #HashedCollection.
	self assert: remoteClass instanceVariableNames equals: HashedCollection instVarNames.