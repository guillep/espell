as yet unclassified
compiledMethod: anEPVMCompiledMethodMirror objectAt: anInteger 
	
	| result |
	result := self
		handle: anEPVMCompiledMethodMirror target
		executePrimitive: 68
		withArgs: { anInteger }.
	^ self mirrorOn: result