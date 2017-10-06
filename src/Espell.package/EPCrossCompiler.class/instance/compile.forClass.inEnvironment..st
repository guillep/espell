compiling
compile: sourceCode forClass: aClass inEnvironment: anEnvironment

	| localCompiledMethod binding |
	binding := EPCrossCompilerBinding new class: aClass; environment: anEnvironment.
	[localCompiledMethod := self basicCompileSourceCode: sourceCode forClass: binding. ]
		on: OCUndeclaredVariableWarning
		do: [ :e | 
			e resume:
				(EPUndeclaredBinding new
					name: e node name;
					objectSpace: anEnvironment;
					yourself) ].
	^ self translateToRemoteCompiledMethod: localCompiledMethod