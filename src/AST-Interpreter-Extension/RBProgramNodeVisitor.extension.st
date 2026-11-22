Extension { #name : 'RBProgramNodeVisitor' }

{ #category : '*AST-Interpreter-Extension' }
RBProgramNodeVisitor >> visitClassDefinition: anEPASTClassDefinition [ 
	
	^ anEPASTClassDefinition message acceptVisitor: self
]

{ #category : '*AST-Interpreter-Extension' }
RBProgramNodeVisitor >> visitTraitDefinition: anEPASTClassDefinition [ 
	
	^ anEPASTClassDefinition message acceptVisitor: self
]
