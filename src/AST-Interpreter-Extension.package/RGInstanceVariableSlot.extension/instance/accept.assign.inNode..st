*AST-Interpreter-Extension
accept: anInterpreter assign: aValue inNode: aVariableNode

	^ anInterpreter write: aValue at: self index named: name