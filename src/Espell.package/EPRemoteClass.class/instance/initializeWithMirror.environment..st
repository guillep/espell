initialize-release
initializeWithMirror: aMirror environment: anEnvironment

	^ super
		initializeWithMirror: aMirror asClassMirror
		environment: anEnvironment