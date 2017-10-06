tests
testClassName

	| remoteClass |
	remoteClass := environment classNamed: #HashedCollection.
	self assert: remoteClass name equals: HashedCollection name.