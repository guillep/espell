interpreting
evaluateCode: someCode withTemps: aCollectionOfTemps
	self flag: 'move the parser to a method that compiles it'.
	^self evaluateAST: (RBParser parseExpression: someCode) withTemps: aCollectionOfTemps 