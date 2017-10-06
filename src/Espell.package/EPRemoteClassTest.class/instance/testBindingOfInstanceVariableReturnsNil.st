tests
testBindingOfInstanceVariableReturnsNil

	| object |
	object := environment globalNamed: #HashedCollection.
	self assert: (object bindingOf: 'tally') isNil.