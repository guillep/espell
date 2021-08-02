*AST-Interpreter-Extension
accept: anInterpeter assign: value inNode: aVariableNode

	"If it is not an arg, it is a normal temporary"
	^ anInterpeter write: value temporaryAt: -1 named: name