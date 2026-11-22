Extension { #name : 'InstanceVariableSlot' }

{ #category : '*AST-Interpreter-Core' }
InstanceVariableSlot >> accept: anInterpreter assign: aValue inNode: aVariableNode [
	^ anInterpreter write: aValue at: index named: name
]

{ #category : '*AST-Interpreter-Core' }
InstanceVariableSlot >> readWith: anInterpreter inNode: aVariableNode [    
	^ anInterpreter readInstVarAt: index named: name
]
