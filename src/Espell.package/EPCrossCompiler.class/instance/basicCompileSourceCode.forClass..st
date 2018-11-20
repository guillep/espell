private
basicCompileSourceCode: sourceCode forClass: aClass

	| options |
	options := #().
	aClass className == #Context ifTrue: [ options := #(+ optionLongIvarAccessBytecodes) ].
	
	^ (OpalCompiler new
		options: options;
		source: sourceCode;
		class: aClass;
		environment: aClass environment;
		requestor: nil;
		failBlock: [ self error ];
		parse) generate