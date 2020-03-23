accessing variables
allInstanceVariables
	| basicClass |
	
	basicClass := self basicClassFromEnvironment .
	basicClass ifNil: [ ^#() ].
	^ basicClass allInstVarNames collectWithIndex: [ :ivName :i | ivName -> (self instanceVariableAtIndex: i) ]