interpretation
evaluateAST: someAST
	self 
		methodContextFor: someAST methodNode
		receiver: evaluator objectSpace nilObject
		message: (Message selector: #DoIt arguments: #()).
	gotoContext :=  false.
	
	^self interpret: someAST