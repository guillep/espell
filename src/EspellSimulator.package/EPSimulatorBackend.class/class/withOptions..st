instance-creation
withOptions: options

	| simulator |
	simulator := StackInterpreterSimulator newWithOptions: options.
	simulator desiredNumStackPages: 8.
	simulator instVarNamed: 'assertVEPAES' put: false.
	simulator ensureMemoryMap.
	simulator initStackPages.
	^ self simulator: simulator