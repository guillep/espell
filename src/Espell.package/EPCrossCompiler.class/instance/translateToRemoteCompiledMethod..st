converting
translateToRemoteCompiledMethod: localCompiledMethod

	| methodMirror methodSize |
	methodSize := localCompiledMethod bytecode size + CompiledMethodTrailer empty size.
	methodMirror := self
						createCompiledMethodWithSize: methodSize
						andHeader: localCompiledMethod header.
	methodMirror bytecodes: localCompiledMethod bytecode.
	localCompiledMethod allLiterals withIndexDo: [ :literal :index |
		methodMirror literalAt: index put: (self transformLiteral: literal asLiteralInObjectSpace: objectSpace).
	].
	^methodMirror