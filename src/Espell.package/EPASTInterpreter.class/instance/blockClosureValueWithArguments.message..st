reflective
blockClosureValueWithArguments: aBlockClosure message: aMessage
	
	^ super blockClosureValueWithArguments: (self unwrapBlockClosure: aBlockClosure) message: aMessage