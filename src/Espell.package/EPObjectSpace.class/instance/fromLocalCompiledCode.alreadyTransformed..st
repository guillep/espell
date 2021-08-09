transformations
fromLocalCompiledCode: localCompiledCode alreadyTransformed: alreadyTransformed

	| methodSize methodMirror header |

	alreadyTransformed at: localCompiledCode ifPresent: [ :e | ^ e ]. 
	
   methodSize := localCompiledCode bytecode size + CompiledMethodTrailer empty size.
	header := self convertHeaderToTargetPlatform: localCompiledCode.

	methodMirror := localCompiledCode isCompiledBlock 
		ifTrue: [ self backend
						createCompiledBlockWithSize: methodSize
						andHeader: header ]
		ifFalse: [ self backend
						createCompiledMethodWithSize: methodSize
						andHeader: header ].

	methodMirror bytecodes: localCompiledCode bytecode.

	alreadyTransformed at: localCompiledCode put: methodMirror.
	
	localCompiledCode allLiterals withIndexDo: [ :literal :index | 
		methodMirror literalAt: index put: (self transformLiteral: literal alreadyTransformed: alreadyTransformed).
	].

	^methodMirror