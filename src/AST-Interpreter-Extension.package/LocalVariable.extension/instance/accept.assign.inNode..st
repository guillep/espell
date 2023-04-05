*AST-Interpreter-Extension
accept: anInterpeter assign: value inNode: aVariableNode

	^ anInterpeter write: value temporaryAt: -1 named: name