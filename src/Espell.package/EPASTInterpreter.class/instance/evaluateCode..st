interpretation
evaluateCode: someCode
	^self evaluateAST: (self compile: someCode)