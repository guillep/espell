Extension { #name : 'Context' }

{ #category : '*AST-Interpreter-Core' }
Context >> asASTInterpreterContext [
	^ (self isBlockContext 
		ifTrue: [ AIBlockContext ]
		ifFalse: [ AIMethodContext ]) fromVMContext: self 
]

{ #category : '*AST-Interpreter-Core' }
Context >> returnContext [
	^ self methodReturnContext
]
