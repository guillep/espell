Extension { #name : 'RGInstanceVariableSlot' }

{ #category : '*AST-Interpreter-Extension' }
RGInstanceVariableSlot >> accept: anInterpreter assign: aValue inNode: aVariableNode [

	^ anInterpreter write: aValue at: self index named: name
]

{ #category : '*AST-Interpreter-Extension' }
RGInstanceVariableSlot >> readWith: anInterpreter inNode: aVariableNode [    

	^ anInterpreter readInstVarAt: self index named: name
]
