execution
createProcessWithPriority: aPriority doing: anExpression withTemps: someTemps
	| method aContext  |
	method := self methodBuilder createDoit: anExpression withTemps: someTemps inObjectSpace: self.
	aContext := self contextBuilder createContextForMethod: method inObjectSpace: self.
	^self processBuilder createProcessForContext: aContext andPriority: aPriority inObjectSpace: self.