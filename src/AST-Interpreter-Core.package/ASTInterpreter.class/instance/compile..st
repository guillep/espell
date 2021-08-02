interpretation
compile: aString
	| ast |
	ast := RBParser parseExpression: aString.
	[ ast methodNode doSemanticAnalysisIn: ProtoObject ]
		on: OCUndeclaredVariableWarning do: [ :e | self error: 'Undeclared variable', e variableNode name ].
	^ ast