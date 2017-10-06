method evaluation
closureAST: aClosure forReceiver: aReceiver
	| astToBind compilationContext |
	
	astCache at: aClosure ifPresent: [ :ast | ^ ast ].
	
	astToBind := aClosure parseTree copyInContext: Dictionary new.
	compilationContext := self class compiler compilationContext.
	compilationContext class: (PBClassDefinition on: aClosure methodClass environment: evaluator environment).
	
	^ astCache at: aClosure put: (astToBind doSemanticAnalysisInContext: compilationContext).