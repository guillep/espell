execution
executionWithReceiver: aReceiver andArguments: anArrayOfArguments
	
	^ EPPrimitiveExecution new
		receiver: aReceiver;
		arguments: anArrayOfArguments;
		primitive: self;
		yourself