accessing
sourceCode

	^ backend objectSpace sourceCodeManager
		sourceCodeOfMethod: self
		ifAbsent: [ self decompile decompileString ]