compiling
compileDoIt: sourceCode

	| localCompiledMethod |
	localCompiledMethod := self basicCompileDoItFromSourceCode: sourceCode.
	^ self translateToRemoteCompiledMethod: localCompiledMethod