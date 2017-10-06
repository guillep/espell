reflective
blockClosureOnDo: aBlockClosure message: aMessage
	
	^ super blockClosureOnDo: (self unwrapBlockClosure: aBlockClosure) message: aMessage