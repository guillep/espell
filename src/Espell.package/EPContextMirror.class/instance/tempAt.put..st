accessing
tempAt: anIndex put: anObjectMirror
	
	self executePrimitive: 211 withArgs: { anIndex . anObjectMirror target }