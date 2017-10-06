primitives
initializeTempsInStackOfContext: anEPContextMirror 
	
	self executePrimitive: 76 withArgs: { anEPContextMirror method numberOfTemps }