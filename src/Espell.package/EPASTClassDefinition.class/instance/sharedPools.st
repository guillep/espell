accessing
sharedPools
	

	| assignmentNode block |
	assignmentNode := message statements first.
	block := assignmentNode value arguments first.
	^ block body statements first messages sixth arguments first
		value substrings collect: [ :name | RBVariableNode named: name asSymbol ].