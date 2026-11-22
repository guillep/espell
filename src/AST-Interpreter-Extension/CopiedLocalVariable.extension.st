Extension { #name : 'CopiedLocalVariable' }

{ #category : '*AST-Interpreter-Extension' }
CopiedLocalVariable >> accept: anInterpeter assign: value inNode: aVariableNode [

	"If it is not an arg, it is a normal temporary"
	^ anInterpeter write: value temporaryAt: -1 named: name
]

{ #category : '*AST-Interpreter-Extension' }
CopiedLocalVariable >> readWith: anInterpreter inNode: aVariableNode [

	^ anInterpreter readTemporaryAt: -1 named: name
]
