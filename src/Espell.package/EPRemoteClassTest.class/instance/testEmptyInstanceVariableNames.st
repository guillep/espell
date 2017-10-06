tests
testEmptyInstanceVariableNames

	| remoteClass |
	remoteClass := environment classNamed: #Object.
	self assert: remoteClass instanceVariableNames isEmpty.