special
executePrimitiveMethod: aCompiledMethod withArguments: arguments

	| result |
	result := self backend
			executePrimitiveMethod: aCompiledMethod
			on: self
			withArguments: arguments.
	
	self assert: self backend stackIsEmpty. 
	^ result.