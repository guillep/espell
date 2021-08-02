private
basicCompileDoItFromSourceCode: sourceCode

	"Ugly. We should not build a remote environment on demand like this. Think wether to put it in the object space or make the cross compiler know it."
	| highLevelUndefinedObjectClass env |
	env := EPRemoteEnvironment on: objectSpace backend systemDictionary.
	highLevelUndefinedObjectClass := env classForClassMirror: objectSpace nilObject basicClass.
	
	^ (OpalCompiler new
		options: #(+ optionFullBlockClosure);
		noPattern: true;
		source: sourceCode;
		encoderClass: EncoderForSistaV1;
		class: highLevelUndefinedObjectClass;
		environment: (EPDummyEnvironment on: objectSpace);
		requestor: nil;
		productionEnvironment: self class environment;
		failBlock: [ self error ];
		parseDoIt) generate

