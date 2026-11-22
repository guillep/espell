Extension { #name : 'TemporaryVariable' }

{ #category : '*AST-Interpreter-Core' }
TemporaryVariable >> readWith: anInterpreter inNode: aVariableNode [

	^ anInterpreter readTemporaryAt: -1 named: name
]
