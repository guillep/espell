running
setUp

	super setUp.
	objectSpace := EPTestResource current objectSpace.
	environment := (EPRemoteEnvironment
			on: objectSpace backend systemDictionary)
			imageFileName: EPTestResource current imageFileName;
			yourself