visiting
visitArgumentNode: aVariableNode 
	| definingScope |
	definingScope := aVariableNode binding originalVar definingScope.
	(self optimizedSend: definingScope node) not ifTrue: [ 
		| argIndex |
		argIndex := definingScope node argumentNames indexOf: aVariableNode name.
		^ self readArgumentAt: argIndex node: aVariableNode
	].
	"If it is not an arg, it is a normal temporary"
	^ self readTemporaryAt: -1 named: aVariableNode name