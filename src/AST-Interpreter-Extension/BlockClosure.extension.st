Extension { #name : 'BlockClosure' }

{ #category : '*AST-Interpreter-Extension' }
BlockClosure >> asASTBlockClosure [
	^ASTBlockClosure new
		homeContext: self home asASTInterpreterContext;
		code: self sourceNode.

]
