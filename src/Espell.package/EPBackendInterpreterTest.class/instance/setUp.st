running
setUp

	super setUp.
	objectSpace := EPTestResource current objectSpace.
	interpreter := (EPASTEvaluator new 
		codeProvider: ((EPRemoteEnvironment
			on: objectSpace backend systemDictionary)
			imageFileName: EPTestResource current imageFileName;
			yourself);
		objectSpace: objectSpace backend)