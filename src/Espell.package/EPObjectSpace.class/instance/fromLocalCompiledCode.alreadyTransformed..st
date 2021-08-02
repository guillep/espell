transformations
fromLocalCompiledCode: localCompiledCode alreadyTransformed: alreadyTransformed

	| methodSize methodMirror |

	alreadyTransformed at: localCompiledCode ifPresent: [ :e | ^ e ]. 
	
   methodSize := localCompiledCode bytecode size + CompiledMethodTrailer empty size.

	methodMirror := localCompiledCode isCompiledBlock 
		ifTrue: [ self backend
						createCompiledBlockWithSize: methodSize
						andHeader: localCompiledCode header ]
		ifFalse: [ self backend
						createCompiledMethodWithSize: methodSize
						andHeader: localCompiledCode header ].

	methodMirror bytecodes: localCompiledCode bytecode.

	alreadyTransformed at: localCompiledCode put: methodMirror.
	
	localCompiledCode allLiterals withIndexDo: [ :literal :index | 
		methodMirror literalAt: index put: (self transformLiteral: literal alreadyTransformed: alreadyTransformed).
	].

	^methodMirror