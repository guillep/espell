context
methodContextFor: aCompiledMethod receiver: receiver message: aMessage
	super methodContextFor: aCompiledMethod receiver: receiver message: aMessage.
	context temporaries keysDo: [ :k | context temporaries at: k put: evaluator objectSpace nilObject ]