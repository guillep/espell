private
basicCompileSourceCode: sourceCode forClass: aClass

	| options |
	options := #(+ optionFullBlockClosure).
	aClass className == #Context ifTrue: [ options := options , #(+ optionLongIvarAccessBytecodes) ].
	
	^ (OpalCompiler new
		options: options;
		source: sourceCode;
		encoderClass: EncoderForSistaV1;
		class: aClass;
		environment: aClass environment;
		requestor: nil;
		productionEnvironment: self class environment;
		failBlock: [ self error ];
		parse) generate