accessing
classPool
	

	| assignmentNode block |
	assignmentNode := message statements first.
	block := assignmentNode value arguments first.
	^ block body statements first messages fifth arguments first
		value substrings collect: [ :name | RBVariableNode named: name asSymbol ].