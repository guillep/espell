initialize-release
initializeWithMirror: aMirror environment: anEnvironment
	^ super
		initializeWithMirror: aMirror asMethodMirror
		environment: anEnvironment