Extension { #name : 'TemporaryVariable' }

{ #category : '*AST-Interpreter-Extension' }
TemporaryVariable >> accept: anInterpeter assign: value inNode: aVariableNode [

	^ anInterpeter write: value temporaryAt: -1 named: name
]
