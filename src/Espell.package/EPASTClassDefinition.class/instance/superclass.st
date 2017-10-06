accessing
superclass

	| assignmentNode block |
	assignmentNode := message statements first.
	block := assignmentNode value arguments first.
	^ block body statements first messages first arguments first.