tests
testBindingisLookedUpInSuperclass

	| object binding |
	"Time uses chronology constants"
	object := environment globalNamed: #Collection.
	binding := (object bindingOf: #DependentsFields).
	
	self assert: binding isClassVariableBinding.
	self assert: binding name equals: #DependentsFields.
	self assert: binding ownerName equals: #Object.