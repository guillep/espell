accessing
tempAt: anIndex
	
	^ backend mirrorOn: (self executePrimitive: 210 withArgs: { anIndex })