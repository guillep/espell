Extension { #name : 'TRBProgramNodeVisitor' }

{ #category : '*AST-Interpreter-Core' }
TRBProgramNodeVisitor >> visitIfFalseNode: aNode [

	^ self visitMessageNode: aNode
]

{ #category : '*AST-Interpreter-Core' }
TRBProgramNodeVisitor >> visitIfNilNode: aNode [

	^ self visitMessageNode: aNode
]

{ #category : '*AST-Interpreter-Core' }
TRBProgramNodeVisitor >> visitIfNode: aNode [

	^ self visitMessageNode: aNode
]

{ #category : '*AST-Interpreter-Core' }
TRBProgramNodeVisitor >> visitIfTrueNode: aNode [

	^ self visitMessageNode: aNode
]

{ #category : '*AST-Interpreter-Core' }
TRBProgramNodeVisitor >> visitToDoNode: aNode [

	^ self visitMessageNode: aNode
]

{ #category : '*AST-Interpreter-Core' }
TRBProgramNodeVisitor >> visitWhileTrueNode: aNode [

	^ self visitMessageNode: aNode
]
