interpreting
evaluateCode: someCode withTemps: aCollectionOfTemps

	^self evaluateAST: (self compile: someCode withTemps: aCollectionOfTemps) 