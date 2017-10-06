execution
execute: anExecution

	| result |
	result := ((EPNamedPrimitiveTable get: self name asSymbol)
		executeOn: anExecution receiver target
		withArguments: (anExecution arguments collect: #target)).
	^self objectSpace objectMirrorOn: result