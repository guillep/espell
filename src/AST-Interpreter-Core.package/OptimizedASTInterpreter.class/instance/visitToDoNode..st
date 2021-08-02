visiting-special-nodes
visitToDoNode: aToDoNode

	| from to lastResult |
	from := (aToDoNode fromNode acceptVisitor: self) asSmallInteger.
	to := (aToDoNode toNode acceptVisitor: self) asSmallInteger.
	from to: to do: [ :index |
		self context temporaries
			at: aToDoNode blockNode arguments first name
			put: (self interpret: (RBLiteralNode value:index)).
		aToDoNode blockNode temporaries do: [ :each |
			self context temporaries
				at: each name
				put: context receiver ].
		"It is for sure a block"
		lastResult := self interpret: aToDoNode blockNode body.
		self ifSkip: [ ^ lastResult ] ].

	^ aToDoNode fromNode acceptVisitor: self