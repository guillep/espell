transformations
fromLocal: aCompiledMethod inEnvironment: anEnvironment
	| methodMirror methodSize |
	methodSize := aCompiledMethod bytecode size + CompiledMethodTrailer empty size.
	methodMirror := self
						createCompiledMethodWithSize: methodSize
						andHeader: aCompiledMethod header.
	methodMirror bytecodes: aCompiledMethod bytecode.
	aCompiledMethod literals withIndexDo: [ :literal :index |
		methodMirror literalAt: index put: (literal asLiteralInObjectSpace: objectSpace).
	].
	^methodMirror