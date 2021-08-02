*AST-Interpreter-Core
asASTInterpreterContext
	^ (self isBlockContext 
		ifTrue: [ AIBlockContext ]
		ifFalse: [ AIMethodContext ]) fromVMContext: self 