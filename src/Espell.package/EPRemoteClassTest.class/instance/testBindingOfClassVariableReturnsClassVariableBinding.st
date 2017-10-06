tests
testBindingOfClassVariableReturnsClassVariableBinding

	| object binding |
	object := environment globalNamed: #Character.
	binding := (object bindingOf: #CharacterTable).
	
	self assert: binding isClassVariableBinding.
	self assert: binding name equals: #CharacterTable.
	self assert: binding ownerName equals: #Character.