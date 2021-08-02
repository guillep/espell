compiling
compileDoIt: sourceCode

	| localCompiledMethod |
	localCompiledMethod := self basicCompileDoItFromSourceCode: sourceCode.
	^ localCompiledMethod asLiteralInObjectSpace: objectSpace alreadyTransformed: Dictionary new