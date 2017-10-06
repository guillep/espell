visiting
visitVariableNode: aVariableNode

	| theBinding |
	theBinding := aVariableNode binding isLiteralVariable
		ifTrue: [ aVariableNode binding assoc ]
		ifFalse: [ aVariableNode binding ].
	^ theBinding readWith: self inNode: aVariableNode