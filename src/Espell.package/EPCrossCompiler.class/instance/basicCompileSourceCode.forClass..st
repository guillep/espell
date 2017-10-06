private
basicCompileSourceCode: sourceCode forClass: aClass

	| options |
	options := #().
	aClass className == #Context ifTrue: [ options := #(+ optionLongIvarAccessBytecodes) ].
	
	^ (OpalCompiler new
		options: options;
		compile: sourceCode
		in: aClass
		notifying: nil
		ifFail: [ self error ]) generate