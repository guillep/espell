initialize-release
interpreter
	evaluator ifNil: [ self error: 'interpreter not initialized for this object space' ].
	^evaluator