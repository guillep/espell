private
basicCompileDoItFromSourceCode: sourceCode

	"Ugly. We should not build a remote environment on demand like this. Think wether to put it in the object space or make the cross compiler know it."
	| highLevelUndefinedObjectClass env |
	env := EPRemoteEnvironment on: objectSpace backend systemDictionary.

	highLevelUndefinedObjectClass := (EPRemoteClass on: (objectSpace nilObject basicClass) environment: env).
	^ (OpalCompiler new
		noPattern: true;
		environment: (EPDummyEnvironment on: objectSpace);
		source: sourceCode; class: highLevelUndefinedObjectClass; requestor: "nil" objectSpace nilObject; failBlock: [self error]; parse) generate