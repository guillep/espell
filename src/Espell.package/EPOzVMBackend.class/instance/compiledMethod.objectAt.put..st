as yet unclassified
compiledMethod: anEPVMCompiledMethodMirror objectAt: anInteger put: aMirror
	
	| result |
	result := self
		handle: anEPVMCompiledMethodMirror target
		executePrimitive: 69
		withArgs: { anInteger . aMirror target }.
	^ self mirrorOn: result