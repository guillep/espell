Extension { #name : 'ArgumentVariable' }

{ #category : '*AST-Interpreter-Extension' }
ArgumentVariable >> readWith: anInterpreter inNode: aVariableNode [

	| definingScope argIndex |
	definingScope := aVariableNode binding scope.
	argIndex := definingScope node argumentNames indexOf: name.
	^ anInterpreter readArgumentAt: argIndex node: aVariableNode
]
