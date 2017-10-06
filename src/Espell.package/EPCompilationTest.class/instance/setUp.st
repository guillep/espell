running
setUp

	super setUp.
	evaluator := objectSpace interpreter.
	environment := EPRemoteEnvironment on: objectSpace backend systemDictionary.