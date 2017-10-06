tests
testBindingOfGlobalReturnsGlobalBinding

	| object binding |
	"Time uses chronology constants"
	object := environment globalNamed: #Object.
	binding := (object bindingOf: #Object).
	
	self assert: binding isGlobalVariableBinding.
	self assert: binding name equals: #Object.