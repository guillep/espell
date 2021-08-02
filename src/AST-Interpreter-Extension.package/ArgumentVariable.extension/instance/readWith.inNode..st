*AST-Interpreter-Extension
readWith: anInterpreter inNode: aVariableNode

	| definingScope argIndex |
	definingScope := aVariableNode binding scope.
	argIndex := definingScope node argumentNames indexOf: name.
	^ anInterpreter readArgumentAt: argIndex node: aVariableNode