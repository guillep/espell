tests
testBindingOfSharedPoolReturnsClassVariableBinding

	| object binding |
	"Time uses chronology constants"
	object := environment globalNamed: #Time.
	binding := (object bindingOf: #SecondsInMinute).
	
	self assert: binding isClassVariableBinding.
	self assert: binding name equals: #SecondsInMinute.
	self assert: binding ownerName equals: #ChronologyConstants.