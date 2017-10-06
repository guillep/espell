transformations
fromLocal: aCompiledMethod
	| methodMirror methodSize |
	methodSize := aCompiledMethod bytecodes size + CompiledMethodTrailer empty size.
	methodMirror := self
						createCompiledMethodWithSize: methodSize
						andHeader: aCompiledMethod header.
	methodMirror bytecodes: aCompiledMethod bytecodes.
	methodMirror literals: aCompiledMethod literals.
	^methodMirror